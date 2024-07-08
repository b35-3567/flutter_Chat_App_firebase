import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/auth/auth_service.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget{
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _pwController =TextEditingController();
  final TextEditingController _confirmPwController =TextEditingController();
  //tap to go to register page
  final void Function()? onTap;
  RegisterPage({super.key,
    required this.onTap
  });

  //register method
  void register(BuildContext context){
  //get auth service
    final _auth =AuthService();
    //get trim
    String password=_pwController.text.trim();
    String confirmPassword=_confirmPwController.text.toString();
  if(password==confirmPassword){
   try{
     _auth.signUpWithEmailPassword(
         _emailController.text,
         _pwController.text);
   }catch(e){
     showDialog(context: context,
         builder:(context)=>AlertDialog(
           title: Text(e.toString()),
         ));
   }
  }
  //password don't macth => show eror to fix
    else{
    showDialog(context: context,
        builder:(context)=>AlertDialog(
          title: Text("Password don't match! "),
        ));
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              //welcom back mesage
              Text("Let's create an account for you",
                style:TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize:16
                ),
              ),

              const SizedBox(height: 25),
              //email texxfield
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController ,
              ),
              const SizedBox(height: 10),
              //pw textfield
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _pwController,
              ),

              const SizedBox(height: 10),
              //pw textfield
              MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: _confirmPwController,
              ),

              const SizedBox(height:25),
//login button
              MyButton(
                text: "Register",
                onTap: ()=>register(context),
              ),

              const SizedBox(height:25),
              //register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have a account?"),
                  GestureDetector(
                    onTap: onTap,
                    child: Text("Login now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}