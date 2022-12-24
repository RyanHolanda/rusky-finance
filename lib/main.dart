import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rusky/presentation/blocs/bloc/data_bloc.dart';
import 'package:rusky/presentation/colors/dark_mode.dart';
import 'package:rusky/presentation/colors/light_mode.dart';
import 'package:rusky/l10n/l10n.dart';
import 'package:rusky/presentation/views/loadings/global_loading.dart';
import 'package:rusky/presentation/views/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      theme: lightmode(),
      darkTheme: darkmode(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => DataBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}
