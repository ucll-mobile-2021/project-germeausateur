import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:germeau_sateur/services/authentication_service.dart';
import 'package:germeau_sateur/screens/homepage.dart';
import 'package:germeau_sateur/screens/signinpage.dart';
import 'package:germeau_sateur/services/barservice.dart';
import 'package:provider/provider.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      Provider<AuthenticationService>(
        create: (_) => AuthenticationService(FirebaseAuth.instance),
      ),
      Provider<BarService>(
        create: (_) => BarService(),
      ),

      StreamProvider(
        create: (context) => context.read<AuthenticationService>().authStateChanges)
    ],
    child: MaterialApp(
      title: 'BIER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AutenticationWrapper(),
    ),
    );
  }
}
      
class AutenticationWrapper extends StatelessWidget{

  const AutenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();

    if(firebaseuser != null){
      return HomePage();
    }
    return SignInPage();
  }
}




