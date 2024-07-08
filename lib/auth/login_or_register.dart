import 'package:flutter/cupertino.dart';
import 'package:untitled/pages/login_page.dart';
import 'package:untitled/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget{
 const LoginOrRegister({super.key});
  @override
  State<LoginOrRegister> createState()=>_LoginOrRgisterState();
}
class _LoginOrRgisterState extends State<LoginOrRegister>{

//initially , showw login page
bool  showLoginPage =true;

//toggle between login and register page
  void togglePage(){
    setState(() {
      showLoginPage =!showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context){
   if(showLoginPage){
     return LoginPage(
       onTap:togglePage ,
     );
   }else{
     return RegisterPage(
       onTap: togglePage,
     );
   }
  }
}