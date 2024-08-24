import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/blocs/course/course_bloc.dart';
import 'package:project2/cubit/auth_cubit.dart';
import 'package:project2/firebase_options.dart';
import 'package:project2/pages/course_details_page.dart';
import 'package:project2/pages/courses_page.dart';
import 'package:project2/pages/home_page.dart';
import 'package:project2/pages/login_page.dart';
import 'package:project2/pages/onboarding_page.dart';
import 'package:project2/pages/profile.dart';
import 'package:project2/pages/reset_password_page.dart';
import 'package:project2/pages/signup_page.dart';
import 'package:project2/pages/splash_page.dart';
import 'package:project2/pages/upload_page.dart';
import 'package:project2/services/pref.service.dart';
import 'package:project2/utils/color_utilis.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
  runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (ctx) => AuthCubit()),
     BlocProvider(create: (ctx) => CourseBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: _CustomScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorUtility.gbScaffold,
        fontFamily: ' PlusJakartaSans',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorUtility.main),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        final String routeName = settings.name ?? '';
         final dynamic data = settings.arguments;
        switch (routeName) {
          case LoginPage.id:
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case SignUpPage.id:
            return MaterialPageRoute(builder: (context) => const SignUpPage());
          case ResetPasswordPage.id:
            return MaterialPageRoute(
                builder: (context) => const ResetPasswordPage());
          case OnBoardingPage.id:
            return MaterialPageRoute(
                builder: (context) => const OnBoardingPage());
          case HomePage.id:
            return MaterialPageRoute(builder: (context) => const HomePage());
          case ProfilePage.id:
            return MaterialPageRoute(builder: (context) => const ProfilePage());
          case UploadFileScreen.id:
            return MaterialPageRoute(builder: (context) => UploadFileScreen());
              case CourseDetailsPage.id:
            return MaterialPageRoute(
                builder: (context) => CourseDetailsPage(
                      course: data,
                    ));

          default:
            return MaterialPageRoute(builder: (context) => const SplashPage());
        }
      },
      initialRoute: SplashPage.id,
    );
  }
}

class _CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      };
}
