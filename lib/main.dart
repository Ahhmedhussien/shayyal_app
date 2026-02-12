// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shyal/Screens/AddAddressScreen.dart';
import 'package:shyal/Screens/AddNewAddresWithMapScreen.dart';
import 'package:shyal/Screens/DriverScreens/DriverHomePage.dart';
import 'package:shyal/Screens/EditProfile.dart';
import 'package:shyal/Screens/ForgetpasswordScreen.dart';
import 'package:shyal/Screens/HomeScreen.dart';
import 'package:shyal/Screens/LoginScreen.dart';
import 'package:shyal/Screens/MyAddressScreen.dart';
import 'package:shyal/Screens/NewPasswordScreen.dart';
import 'package:shyal/Screens/OnboardingScreen.dart';
import 'package:shyal/Screens/OrderHistoryScreen.dart';
import 'package:shyal/Screens/ProfileScreen.dart';
import 'package:shyal/Screens/RegistrationScreen.dart';
import 'package:shyal/Screens/ResetPasswordScreen.dart';
import 'package:shyal/Screens/SplashScreen.dart';
import 'package:shyal/Screens/TrackPackageScreen.dart';
import 'package:shyal/Screens/SendPackageScreen.dart';
import 'package:shyal/const.dart';
import 'package:shyal/generated/l10n.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shyal Online',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: background_color,
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/LoginScreen': (context) => const LoginScreen(),
        '/NewPasswordScreen': (context) => const NewPasswordScreen(),
        '/RegistrationScreen': (context) => const RegistrationScreen(),
        '/ResetPasswordScreen': (context) => ResetPasswordScreen(),
        '/ForgotPasswordScreen': (context) => const ForgotPasswordScreen(),
        '/OnboardingScreen': (context) => const OnboardingScreen(),
        '/HomeScreen': (context) => const HomeScreen(),
        '/ProfileScreen': (context) => const ProfileScreen(),
        '/AddNewAddresScreen': (context) => const AddNewAddresWithMapScreen(),
        '/SendPackageScreen': (context) => const SendPackageScreen(),
        // '/TrackPackageScreen': (context) => const TrackPackageScreen(),
        '/OrderHistoryScreen': (context) => const OrderHistoryScreen(),
        '/MyAddressScreen': (context) => const MyAddressScreen(),
        '/AddAddressScreen': (context) => const AddAddressScreen(),
        '/EditProfile': (context) => const EditProfile(),
        '/DriverHomePage': (context) => const DriverHomePage(),
      },
    );
  }
}
