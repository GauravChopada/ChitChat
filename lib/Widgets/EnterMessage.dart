import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EnterMessage extends StatefulWidget {
  @override
  _EnterMessageState createState() => _EnterMessageState();
}

class _EnterMessageState extends State<EnterMessage> {
  final _controller = new TextEditingController();
  var _enteredMsg = '';

  void _sendmsg() async {
    _controller.clear();
    var user = await FirebaseAuth.instance.currentUser();
    var userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text': _enteredMsg,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData['UserName'],
      'imageUrl': userData['imageUrl']
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Colors.grey[200],
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: TextField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
              fillColor: Colors.grey[50],
              filled: true,
              hintText: ' Type message here...',
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(100.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            controller: _controller,
            onChanged: (value) {
              setState(() {
                _enteredMsg = value;
              });
            },
          )),
          SizedBox(
            width: 5,
          ),
          if (_enteredMsg.trim().isNotEmpty)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).primaryColor,
              ),
              child: IconButton(
                  iconSize: 30,
                  padding: EdgeInsets.all(13),
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: _enteredMsg.trim().isEmpty ? null : _sendmsg),
            )
        ],
      ),
    );
  }
}
