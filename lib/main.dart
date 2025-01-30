import 'package:finance_connect_app/core/theme/app_theme.dart';
import 'package:finance_connect_app/domain/usecases/auth/login_user.dart';
import 'package:finance_connect_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:finance_connect_app/presentation/bloc/device/device_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_connect_app/injection_container.dart' as di;
import 'package:finance_connect_app/presentation/pages/home_page.dart';
import 'package:finance_connect_app/presentation/pages/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        Provider<LoginUser>(
          create: (context) => di.sl<LoginUser>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            loginUser: context.read<LoginUser>(),
          ),
        ),
        BlocProvider(
          create: (context) => di.sl<DeviceBloc>()..add(CheckDeviceType()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: AppTheme.light,
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
      initialRoute: '/',
    );
  }
}
