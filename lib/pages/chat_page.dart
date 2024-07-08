
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/components/chat_bubble.dart';
import 'package:untitled/components/my_textfield.dart';
import 'package:untitled/serviecs/chat/chat_service.dart';

class ChatPage extends StatelessWidget{
  final String receiverEmail;
final String receiverID;
  ChatPage ({
  super.key,
  required this.receiverEmail,
    required this.receiverID
  });
  //text controller
  final TextEditingController _messageController =TextEditingController();
  //chat & auth services
  final ChatService _chatService =ChatService();
  final AuthService _authService =AuthService();
  //send message
void sendMessage() async{
  //if there is something inside the textfield
  if(_messageController.text.isNotEmpty){
    //send the message
    await _chatService.sendMessage(receiverID, _messageController.text);

    //clear text controller
    _messageController.clear();
  }

}
  @override
Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation:0 ),
      body: Column(
        children: [
          //display all message
Expanded(child: _buildMessageList(),

),

          //user input
          _buildUserInput(),
        ],
      ),
    );

  }
  //build message list
Widget _buildMessageList(){
  String senderID =_authService.getCurrentUser()!.uid;
  return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context,snapshot){
        //errors
if(snapshot.hasError){
  return Text("Error");
}
        //loading
if(snapshot.connectionState==ConnectionState.waiting){
  return const Text("Loading");
}
        //return
return ListView(
children: snapshot.data!.docs.map((doc)=>_buildMessageItem(doc)).toList(),
);
      },
  );
}
//build messsage item
Widget _buildMessageItem(DocumentSnapshot doc){
  Map<String,dynamic> data=doc.data() as Map<String,dynamic>;
  //is current usser
bool isCurrentUser= data['senderID']== _authService.getCurrentUser()!.uid;

//algin message to the right iff sender is the current user,otherwise lefft
  var alignment =isCurrentUser?Alignment.centerRight:Alignment.centerLeft;

  return Container(
    alignment: alignment ,
      child: Column(
        crossAxisAlignment:
        isCurrentUser?CrossAxisAlignment.end:CrossAxisAlignment.start,
       children: [
      //   Text(data["message"]),
         ChatBubble(
             message: data["message"],
             isCurrentUser: isCurrentUser)
       ],
      )
  );
}
//build message input
  Widget _buildUserInput(){
  return Row(
children: [
  //texxtfield should take uss mosst of the space
Expanded(child: MyTextField(
  controller: _messageController,
  hintText: "Type a messsage",
  obscureText: false,
),
),
//send button

 Container(
   decoration:const BoxDecoration(color: Colors.green,
   shape: BoxShape.circle),
   margin: const EdgeInsets.only(right: 25),
   child: IconButton(
      onPressed: sendMessage,
      icon: const Icon(Icons.arrow_upward,color: Colors.white,),
   ),
 ),
],
  );
  }
}