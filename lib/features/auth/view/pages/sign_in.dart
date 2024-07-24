import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gif/features/auth/view/pages/sign_up.dart';
import 'package:gif/features/auth/view/widgets/custom_field.dart';
import 'package:gif/features/auth/view_model/auth.dart';
import 'package:gif/features/gif/view/pages/gif_list.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  
  
  final email = TextEditingController();
  final password = TextEditingController();

  //Keys
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.put(AuthController());
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
              child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sign In",style: TextStyle(fontSize: 32),),
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
                          _authController.signIn(email.text, password.text).then((val){
                              if(val==200){
                                Get.offAll(GifList());
                              }
                            }).catchError((error){
                              Get.snackbar("Error", "$error");
                            });
                        }
                      }, 
                      child: const Text("Sign In")
                    ),
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      Get.off(SignUp());
                    },
                    child: RichText(text: const TextSpan(children: [
                      TextSpan(text: "Don't have an account?",style: TextStyle(color: Colors.black)),
                      TextSpan(text: "Sign Up",style: TextStyle(color: Colors.blue)),
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