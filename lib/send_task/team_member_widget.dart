import 'dart:math';

import 'package:caatsec/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamMemberWidget extends StatefulWidget {

  @override
  State<TeamMemberWidget> createState() => _TeamMemberWidgetState();
}

class _TeamMemberWidgetState extends State<TeamMemberWidget> {
  Color _backgroundColor = MyTheme.blueTask;
  bool _isColor1 = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
    {
      _toggleColor();

    },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: _backgroundColor,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Mohamed Kamal",
              style: TextStyle(
                fontSize: 20,
              ),
              ),
              Text("Auditor"),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleColor() {
    setState(() {
      _backgroundColor = _isColor1 ? MyTheme.blueColor : MyTheme.blueTask;
      _isColor1 = !_isColor1;
    });
  }
}
