import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signOut() async{
    await _firebaseAuth.signOut();
    return 'signed out';
  }

  Future<String> signIn({String email, String password}) async{
      try{
        await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        return "Signed in";
      } on FirebaseAuthException catch(e){
          return e.message;
      }
  }
  Future<String> signUp({String email, String password, String confirmPassword}) async{
    if(password != confirmPassword){
      return "Passwords don't match";
    }
      try{
        await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        return "Signed up";
      } on FirebaseAuthException catch(e){
          return e.message;
      }
  }
  
}

class EmailValidator {
  static String validate(String value){
    if(value.isEmpty){
      return "Email can't be empty";
    }
    return null;
  }
}