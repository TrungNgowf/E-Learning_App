import 'dart:io';

import 'package:e_learning_app/dev/AppObservers.dart';
import 'package:e_learning_app/firebase_options.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/utils/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'utils/route_config/page_config.dart';

Future<void> main() async {
  await Global.init();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = AppObservers();
  ZIMKit().init(
    appID: 1697744537,
    appSign: 'a2a63ec992a16596183efee0836eb3871a3f9dbf048634bb18ffb9ea0777ef5b',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (context, child) => GetMaterialApp(
                title: 'E-Learning App',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                  ),
                  useMaterial3: true,
                  primarySwatch: Colors.blue,
                  fontFamily: GoogleFonts.lexend().fontFamily,
                ),
                initialRoute: Routes.INITIAL,
                onGenerateRoute: AppPages.onGenerateRoute,
              )),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class Global {
  static late StorageService storageService;

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await StorageService().init();
  }
}
