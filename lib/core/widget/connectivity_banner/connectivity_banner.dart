import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_bloc.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_state.dart';

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
            "No Internet Connection",
            Colors.red,
          );
        } else if (state is NetworkConnectivityReconnected) {
          return _buildBottomNetworkBanner("Back Online", Colors.green);
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
              color: Colors.white,
              decoration: TextDecoration.none, // Removes underline
            ),
          ),
        ),
      ),
    );
  }
}
