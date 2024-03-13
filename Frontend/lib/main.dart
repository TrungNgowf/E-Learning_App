import 'package:e_learning_app/common/export.dart';
import 'package:e_learning_app/firebase_options.dart';
import 'package:e_learning_app/views/welcome/welcome.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => GetMaterialApp(
              title: 'E-Learning App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                primarySwatch: Colors.blue,
                fontFamily: GoogleFonts.lexend().fontFamily,
              ),
              home: const WelcomeScreen(),
            ));
  }
}
