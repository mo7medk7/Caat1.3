import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_config_provider.dart';
import '../my_theme.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;

  CustomPasswordField({required this.controller});

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: widget.controller,
        obscureText: _isHidden,
        decoration: InputDecoration(
          hintText: 'Password',
          suffixIcon: InkWell(
            onTap: _togglePasswordView,
            child: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              color: provider.isDarkMode() ? MyTheme.whiteColor : MyTheme.greyColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: provider.isDarkMode() ? MyTheme.whiteColor : MyTheme.greyColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: provider.isDarkMode() ? MyTheme.whiteColor : MyTheme.greyColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
