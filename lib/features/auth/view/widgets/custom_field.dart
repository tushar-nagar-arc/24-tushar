import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  const CustomField({super.key, this.isObscure = false,required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      obscureText: isObscure,
      controller: controller,
      validator: (value) {
        if(value == null || value.toString().trim().isEmpty){
          return "$hintText is missing";
        }
        else if(hintText == "Email"){
          if(!EmailValidator.validate(value)){
            return "Email is invalid";
          }
          else {
            return null;
          }
        }
        else{
          return null;
        }
      },

      decoration: InputDecoration(hintText: hintText,contentPadding: const EdgeInsets.all(12),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)),
    );
  }
}