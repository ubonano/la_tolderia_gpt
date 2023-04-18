import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'config/firebase_options.dart';
import 'utils/get_it_setup.dart';
import 'config/logger_setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogger();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp(
    name: 'SecondaryApp',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();

  await initializeDateFormatting('es_ES');

  runApp(const App());
}
