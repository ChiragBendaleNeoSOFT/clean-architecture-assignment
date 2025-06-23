import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/connectivity_bloc.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/connectivity_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityDisconnected) {
          return _buildBanner("No Internet Connection", Colors.red);
        } else if (state is ConnectivityReconnected) {
          return _buildBanner("Back Online", Colors.green);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBanner(String message, Color color) {
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
              fontSize: 14, // Keep this reasonably small
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
