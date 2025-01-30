import 'package:finance_connect_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:finance_connect_app/presentation/bloc/device/device_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: BlocBuilder<DeviceBloc, DeviceState>(
        builder: (context, state) {
          if (state is DeviceLoaded) {
            if (state.deviceType == 'Phone' || state.deviceType == 'iPhone') {
              return _buildMobileLayout();
            } else if (state.deviceType == 'Desktop' ||
                state.deviceType == 'Web') {
              return _buildDesktopLayout();
            } else {
              return Center(child: Text('Unknown device type'));
            }
          } else if (state is DeviceError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Center(
      child: Text('Mobile Layout'),
    );
  }

  Widget _buildDesktopLayout() {
    return Center(
      child: Text('Desktop/Web Layout'),
    );
  }
}
