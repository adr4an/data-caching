import 'package:data_caching/config/theme/app_theme.dart';
import 'package:data_caching/core/dependency_injection/di.dart';
import 'package:data_caching/features/home/view/bloc/home_blocs/home_bloc.dart';
import 'package:data_caching/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.system,

        /* immediately call the event to load from 
          either the server or local host */
        home: BlocProvider<HomeBloc>(
          create: (context) =>  
            di<HomeBloc>()..add(const HomeCallProductsEvent()),
          child: const HomePage(),
        )
    );
  }
}
