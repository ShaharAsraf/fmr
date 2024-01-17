import 'package:flutter/material.dart';

import 'main_bloc.dart';

class MainBlocProvider extends InheritedWidget {
  final MainBloc bloc;

  MainBlocProvider({Key? key, required Widget child})
      : bloc = MainBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(oldWidget) => true;

  static MainBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainBlocProvider>()!.bloc;
  }
}
