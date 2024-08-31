import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 300,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/logo.png"),
            ),
            Text("Our One-Stop Shop for Everything You Love.")
          ],
        ),
      ),
    );
  }
}