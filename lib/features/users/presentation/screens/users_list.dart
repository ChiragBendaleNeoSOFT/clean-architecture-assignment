import 'dart:async';

import 'package:clean_architecture_assignment/core/blocs/locale_bloc/locale_bloc.dart';
import 'package:clean_architecture_assignment/core/blocs/locale_bloc/locale_event.dart';
import 'package:clean_architecture_assignment/core/utils/app_colors.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_bloc.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_state.dart';
import 'package:clean_architecture_assignment/features/users/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_assignment/features/users/presentation/bloc/user_event.dart';
import 'package:clean_architecture_assignment/features/users/presentation/bloc/user_state.dart';
import 'package:clean_architecture_assignment/features/users/presentation/widgets/user_list_tile.dart';
import 'package:clean_architecture_assignment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/locale.dart' as lc;

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final TextEditingController searchController = TextEditingController();
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUsers());
    _scrollController.addListener(onScrollEnd);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  void onScrollEnd() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<UserBloc>().add(LoadMoreUsers());
    }
  }

  void onSearchChanged(String query) {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<UserBloc>().add(SearchUsers(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    final localeBloc = context.read<LocaleBloc>();

    return BlocListener<NetworkConnectivityBloc, NetworkConnectivityState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is NetworkConnectivityDisconnected) {
          userBloc.add(RefreshFetchUsers());
        } else if (state is NetworkConnectivityReconnected) {
          userBloc.add(LoadMoreUsers());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.appBarColor,
          title: Text(
            AppLocalizations.of(context)?.appTitle ?? "",
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Text(
              'HI',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 2),
            Switch.adaptive(
              value: localeBloc.state.locale == 'en',
              activeColor: AppColors.whiteColor,
              inactiveThumbColor: AppColors.whiteColor,
              inactiveTrackColor: AppColors.appBarColor,
              onChanged: (loc) {
                if (localeBloc.state.locale == 'en') {
                  localeBloc.add(ChangeLocaleEvent(lc.Locale.parse("hi")));
                } else {
                  localeBloc.add(ChangeLocaleEvent(lc.Locale.parse("en")));
                }
              },
            ),
            Text(
              'EN',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 15),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                key: const Key('user_search_textfield'),
                controller: searchController,
                onChanged: onSearchChanged,
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.greyDarkColor,
                  ),
                  hintText: AppLocalizations.of(context)?.searchUser ?? "",
                  hintStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.blackColor),
                    onPressed: () {
                      searchController.clear();
                      userBloc.add(SearchUsers(""));
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: RefreshIndicator(
            key: _refreshKey,
            onRefresh: () async {
              userBloc.add(RefreshFetchUsers());
            },
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                switch (state) {
                  case UserDataLoadingState():
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        key: Key('loading_indicator'),
                      ),
                    );
                  case UserDataSearchSuccessState(results: final users):
                  case UserDataSuccessState(users: final users):
                  case UserDataLoadingMoreState(users: final users):
                    if (users.isEmpty && State is UserDataSearchSuccessState) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)?.noUsersFoundForSearch ??
                              "",
                        ),
                      );
                    } else if (users.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)?.noUsers ?? "",
                        ),
                      );
                    }
                    return ListView.separated(
                      key: const Key('user_list_view'),
                      controller: _scrollController,
                      itemCount: state is UserDataLoadingMoreState
                          ? users.length + 1
                          : users.length,
                      itemBuilder: (context, index) {
                        if (index == users.length) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 20),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(
                                key: Key('loading_indicator'),
                              ),
                            ),
                          );
                        }
                        return UserListTileWidget(user: users[index]);
                      },
                      separatorBuilder: (_, _) => SizedBox(height: 10.h),
                    );

                  case UserDataFailureState(message: final message):
                    return Center(
                      child: Text(key: Key("error_message_text"), message),
                    );

                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
