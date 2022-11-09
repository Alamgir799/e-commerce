import 'package:ecommerce/ui/route/route.dart';
import 'package:ecommerce/ui/widgets/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthHelper {

  Future signUp(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        Utils().toastMessage("SignUp Successfull");
        Get.toNamed(userData);
      } else {
        Utils().toastMessage("sign up failed");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils().toastMessage("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Utils().toastMessage("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  // Sign

  Future signIn(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        Get.toNamed(userData);
      } else {
        Utils().toastMessage("Login failed");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils().toastMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Utils().toastMessage("Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }
  }
}
