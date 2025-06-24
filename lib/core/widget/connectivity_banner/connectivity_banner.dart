import 'package:clean_architecture_assignment/core/utils/app_colors.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_bloc.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_state.dart';
import 'package:clean_architecture_assignment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkConnectivityBanner extends StatelessWidget {
  const NetworkConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkConnectivityBloc, NetworkConnectivityState>(
      builder: (context, state) {
        if (state is NetworkConnectivityDisconnected) {
          return _buildBottomNetworkBanner(
            AppLocalizations.of(context)?.noInternetConnection ??
                "No Internet Connection",
            AppColors.redColor,
          );
        } else if (state is NetworkConnectivityReconnected) {
          return _buildBottomNetworkBanner(
            AppLocalizations.of(context)?.backOnline ?? "Back Online",
            AppColors.greenColor,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBottomNetworkBanner(String message, Color color) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          color: color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            message,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.whiteColor,
              decoration: TextDecoration.none, // Removes underline
            ),
          ),
        ),
      ),
    );
  }
}
