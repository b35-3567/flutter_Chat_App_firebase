//import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/serviecs/chat/chat_service.dart';

import '../components/my_drawer.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget{
 HomePage({super.key});
// void logout(){
// //get auth service
// final _auth=AuthService();
// _auth.signOut();
// }
  //chat & auth sểvice
final ChatService _chatService=ChatService();
final AuthService _authService=AuthService();

@override
  Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Text("Home"),
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.grey,
    elevation:0 ,
    // actions: [
    //   //logout button
    //   IconButton(onPressed: logout, icon: Icon(Icons.logout)
    //   )
    // ],
    ),
    drawer:  const MyDrawer(),
    body: _buildUserList(),
  );
}
//build a list of users except for the loggged in user
Widget  _buildUserList(){
  return StreamBuilder(stream: _chatService.getUserStream(),
      builder: (context,snapshot){
    //error
if(snapshot.hasError){
  return const Text("Error");
}
        //loaidng
if(snapshot.connectionState == ConnectionState.waiting){
  return const Text("Loading...");
}

        //return list view
        return ListView(
          children: snapshot.data!.map<Widget>((userData)=>_buildUserListItem(userData,context)).toList(),
        );
      });
}
//build individual list title for user
 Widget  _buildUserListItem(Map<String,dynamic>userData,BuildContext context){
  //display all users  expect curent  user
   if(userData["email"] != _authService.getCurrentUser()) {
     return UserTile(
       text: userData["email"],
       onTap: (){
         //tapped on a user -> go to chat page
         Navigator.push(context,MaterialPageRoute(builder: (context)=> ChatPage(
           receiverEmail: userData["email"],
           receiverID: userData["uid"],
         ),
         ),
         );
       },
     );
   }else{
      return Container(

      );
   }
 }
}