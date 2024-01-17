import 'package:flutter/material.dart';
import 'package:fmr/src/app.dart';

import 'src/utils/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsUtils.init();
  runApp(const MyApp());
}
