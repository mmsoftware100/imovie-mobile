import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class mmcafe extends StatefulWidget {
  @override
  _mmcafeState createState() => _mmcafeState();
}

class _mmcafeState extends State<mmcafe> {
  final List<String> messageList = <String>["ကြိုဆိုပါတယ်","အားလုံးပဲ ကံကောင်းကြပါစေ"];

  final TextEditingController messageTextEditingController = new TextEditingController();
  final ScrollController messageListScrollController = new ScrollController();

  void _receiveMessage(String msg){
    setState(() {
      messageList.add(msg);
    });
    scrollToBottom();
  }


  @override
  void initState() {
    print("initState");

  }


  @override
  void dispose(){
    messageTextEditingController.dispose();
    messageListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: messageListView()),
        messageInputBox(),
        SizedBox(height: 75,)
      ],
    );
  }

  void sendMessage(){
    String msg = messageTextEditingController.text;
    if(msg.length == 0 ) return;
    setState(() {
      messageList.add(msg);
    });
    messageTextEditingController.clear();
    scrollToBottom();

  }
  void scrollToBottom(){
    messageListScrollController.animateTo(
        messageListScrollController.position.maxScrollExtent+100,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn
    );
  }
  Widget messageListView() => ListView.separated(
      controller: messageListScrollController,
      itemBuilder: (BuildContext buildContext, int index){
        //return Center(child: Text(index.toString()));
        return Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.fromLTRB(20, 8, 8, 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey[100],
          ),
          child: Text(messageList[index],style: TextStyle(color: Colors.blue),),
        );
      },

      separatorBuilder: (BuildContext buildContext, int index){
        return Divider(
          height: 1,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        );
      },
      itemCount: messageList.length
  );


  Widget messageInputBox() => Container(
    //color: Colors.redAccent,
    child: TextField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      controller: messageTextEditingController,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText : "Message",
        labelStyle: TextStyle(color: const Color(0xFFDC1E16)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.message,color: const Color(0xFFDC1E16),),
        suffixIcon: IconButton(
          onPressed: (){
            print("suffixIcon onPressed and clear input");
            sendMessage();
          },
          icon: Icon(Icons.send,color:const Color(0xFFDC1E16)),
        ),
        hintText: "Type your message here",
      ),
    ),
  );
}
