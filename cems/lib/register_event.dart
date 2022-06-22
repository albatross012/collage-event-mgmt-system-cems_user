import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterEvent extends StatefulWidget {
  const RegisterEvent({Key? key}) : super(key: key);

  @override
  State<RegisterEvent> createState() => _RegisterEventState();
}

class _RegisterEventState extends State<RegisterEvent> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("hello"),
    );
  }
}
