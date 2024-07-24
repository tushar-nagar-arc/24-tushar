import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gif/core/services/local_storage.dart';

class AuthController extends GetxController{
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;


  Future<int> signUp(String email,String password) async {
    isLoading.value=true;
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await LocalStorage.storeUserInfo(email);
      return 200;
    }

    on FirebaseAuthException {
      throw "Firebase authentication error";
    }

    catch(e){
      rethrow;
    }
    finally{
      isLoading.value = false;
    }
  }

  Future signIn(String email,String password) async {
    isLoading.value=true;
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await LocalStorage.storeUserInfo(email);
      return 200;
    }

    on FirebaseAuthException{
      throw "Firebase authentication error";
    }

    catch(e){
      rethrow;
    }
    finally{
      isLoading.value=false;
    }
  }

}