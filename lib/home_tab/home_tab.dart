import 'package:caatsec/chat_ai/ai_chat.dart';
import 'package:caatsec/model/task.dart';
import 'package:caatsec/todo_tab/to_do_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../analysis/analysis_page.dart';
import '../components/custom_dashboard_item.dart';
import '../group_chat/group_chat_page.dart';
import '../my_theme.dart';
import '../providers/app_config_provider.dart';

@pragma('vm:entry-point')
class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

String _user = '';


  @override
  void initState() {
    super.initState();
    _loadUser();
  }


  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('userEmail') ?? '';
    setState(() {
      _user = user.split('@')[0];
    });
  }




  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      backgroundColor: provider.isDarkMode()? MyTheme.blueDarkColor: MyTheme.primaryLightColor ,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello $_user!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text('Welcome Back',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/user.jpg'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration:  BoxDecoration(
                  color:provider.isDarkMode()? Theme.of(context).primaryColor:MyTheme.whiteColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [

                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return AnalysisPage();
                        }));
                      },
                      child: customitemDashBoard( title: 'Analysis', iconData: CupertinoIcons.graph_circle, background:  Colors.green,)),

                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ToDoTab();
                        }));
                      },
                      child: customitemDashBoard( title: 'Tasks', iconData: CupertinoIcons.doc_checkmark_fill, background:  Colors.blueGrey,)),

                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChatScreen();
                        }));
                      },
                      child: customitemDashBoard( title: 'Room Chat', iconData: CupertinoIcons.chat_bubble_2, background:  Colors.brown,)),


                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const ChatAiPage();
                      }));
                    },
                    child: customitemDashBoard( title: 'Ai Chat', iconData:  CupertinoIcons.keyboard_chevron_compact_down, background:  Colors.deepOrange,
                    ),
                  ),

                  customitemDashBoard( title: 'About Us', iconData:  CupertinoIcons.app_badge_fill, background:  Colors.indigoAccent,
                  ),

                  customitemDashBoard( title: 'Settings', iconData:  CupertinoIcons.settings, background:  Colors.black,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }


}


