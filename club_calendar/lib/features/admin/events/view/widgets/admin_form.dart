 import 'package:flutter/material.dart';
class admin_form extends StatefulWidget {
  final Widget child;
  const admin_form({Key? key,required this.child}) : super(key: key);

  @override
  State<admin_form> createState() => _admin_formState();
}

class _admin_formState extends State<admin_form> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:widget.child ,
    );
  }
}

