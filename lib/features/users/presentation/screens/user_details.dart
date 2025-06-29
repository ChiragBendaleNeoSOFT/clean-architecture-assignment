import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_assignment/core/utils/app_colors.dart';
import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserEntity user;
  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leadingWidth: 60,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded),
          iconSize: 20.sp,
          color: AppColors.whiteColor,
        ),
        title: Text(
          AppLocalizations.of(context)?.userDetails ?? "",
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 52.r,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: user.avatar,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppLocalizations.of(context)?.userInformation ?? ""} : ",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12.h),

                Text(
                  "${AppLocalizations.of(context)?.name ?? ""}: ${user.firstName} ${user.lastName}",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "${AppLocalizations.of(context)?.email ?? ""}: ${user.email}",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
