
import 'package:flutter/cupertino.dart';


import '../model/my_users.dart';

class AuthhProvider extends ChangeNotifier {
  MyUser? currentUser;
  String? role = "" ;
  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }



}
