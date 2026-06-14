import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerUser({
    required String email,
    required String password,
 }) async {
    try{
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch(e){
      throw e.message ?? "Registration Failed";
    } catch(e){
      throw "Something went wrong";
    }
  }

  Future<User?> loginUser({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch(e){
      throw e.message ?? "Login failed";
    } catch(e){
      throw "Something went wrong";
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }

}