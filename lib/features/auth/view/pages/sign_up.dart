import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gif/features/auth/view/pages/sign_in.dart';
import 'package:gif/features/auth/view/widgets/custom_field.dart';
import 'package:gif/features/auth/view_model/auth.dart';
import 'package:gif/features/gif/view/pages/gif_list.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  
  //controller

  final email = TextEditingController();
  final password = TextEditingController();

  //Keys
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthController _authController = AuthController();
    return  Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              Get.offAll(GifList());
            }
          , child: const Text("Skip"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
              child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sign Up",style: TextStyle(fontSize: 32),),
                  const SizedBox(height: 20,),
                  CustomField(hintText: "Email", controller: email),
                  const SizedBox(height: 20,),
                  CustomField(isObscure: true, hintText: "Password", controller: password),
                  const SizedBox(height: 20,),
                  Obx(
                     () => 
                     _authController.isLoading.value ? const Center(child: CircularProgressIndicator(),) :
                     ElevatedButton(
                      style: ElevatedButton.styleFrom(fixedSize: Size(MediaQuery.of(context).size.width, 50),backgroundColor: Colors.amber),
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _authController.signUp(email.text, password.text).then((val){
                            if(val==200){
                              Get.offAll(GifList());
                            }
                          }).catchError((error){
                            Get.snackbar("Error", "$error");
                          });
                        }
                      }, 
                      child: const Text("Sign Up")
                    ),
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      Get.off(SignIn());
                    },
                    child: RichText(text: const TextSpan(children: [
                      TextSpan(text: "Already have an account?",style: TextStyle(color: Colors.black)),
                      TextSpan(text: "Sign In",style: TextStyle(color: Colors.blue)),
                    ])),
                  )
                ],
              ),
            ),
          ),
        ),
        ),
    );
  }
}