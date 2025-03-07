import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class getStartedPage extends StatelessWidget {
  const getStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(52, 78, 163,1),
      body: getUserName(),
    );
  }
}

class getUserName extends StatefulWidget {
  const getUserName({super.key});

  @override
  State<getUserName> createState() => _getUserNameState();
}

class _getUserNameState extends State<getUserName> {

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 100),
          const Text(
            "Welcome to DlyGrind",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Enter your name to get started",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hoverColor: Colors.grey,
                fillColor: Colors.white,
                hintText: "Enter your name",
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String _username = _controller.text;
              if(_username.isEmpty){
                return ;
              }
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: _username,)));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Get Started"),
          ),
        ],
      ),
    );
  }
}
