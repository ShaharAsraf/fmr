import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmr/src/blocs/main/main_bloc_provider.dart';
import 'blocs/ui/ui_bloc.dart';
import 'blocs/ui/ui_bloc_provider.dart';
import 'screens/main/main_screen.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UIBlocProvider(
      child: MainBlocProvider(
        child: ValueListenableBuilder<ThemeData?>(
            valueListenable: uiBloc.theme,
            builder: (BuildContext context, ThemeData? theme, Widget? child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: theme,
                title: 'FMR App',
                builder: (ctx, widget) {
                  return MediaQuery(
                    data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1),
                    child: widget!,
                  );
                },
                onGenerateRoute: appRoutes,
                navigatorObservers: [routeObserver],
              );
            }),
      ),
    );
  }

  Route appRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      default:
        return CupertinoPageRoute(
          builder: (BuildContext context) {
            return const MainScreen();
          },
        );
    }
  }
}
