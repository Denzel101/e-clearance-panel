import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:schoolmanagement/auths/homepage.dart';
import 'package:schoolmanagement/auths/profilesections.dart';
import 'package:schoolmanagement/auths/stakeholders.dart';
import 'package:schoolmanagement/firebase_options.dart';
import 'package:schoolmanagement/locator.dart';
import 'package:schoolmanagement/ob.dart';
import 'package:schoolmanagement/provider/notification_state.dart';

import 'auths/login.dart';
import 'over.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: "dev");
  setUpLocator();
  runApp(MyApp(
    firebaseAuth: FirebaseAuth.instance,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.firebaseAuth}) : super(key: key);
  final FirebaseAuth firebaseAuth;

  String _decideInitialPage() {
    if (firebaseAuth.currentUser != null) {
      return HomePage.id;
    } else {
      return Login.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ChangeNotifierProvider(
        create: (BuildContext context) => NotificationState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: _decideInitialPage(),
          routes: {
            Login.id: (_) => const Login(),
            HomePage.id: (_) => const HomePage(),
            StakeHolders.tag: (_) => const StakeHolders(),
            ProfileSection.routeName: (_) => const ProfileSection(),
            OB.id: (_) => const OB(),
            OverScreen.id: (_) => const OverScreen()
          },
        ),
      ),
    );
  }
}
