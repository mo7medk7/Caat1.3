import 'package:caatsec/chat_ai/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../analysis/analysis_page.dart';
import '../components/custom_dashboard_item.dart';
import '../my_theme.dart';
import '../providers/app_config_provider.dart';

@pragma('vm:entry-point')
class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
                  title: Text('Hello fatma!',
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
                        return const ChatPage();
                      }));
                    },
                    child: customitemDashBoard( title: 'Ai Chat', iconData:  CupertinoIcons.play_rectangle, background:  Colors.deepOrange,
                    ),
                  ),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return AnalysisPage();
                        }));
                      },
                      child: customitemDashBoard( title: 'Analytics', iconData: CupertinoIcons.graph_circle, background:  Colors.green,)),
                  customitemDashBoard( title: 'Audience', iconData:  CupertinoIcons.person_2, background: Colors.purple,),
                  customitemDashBoard(title: 'Comments', iconData: CupertinoIcons.chat_bubble_2, background: Colors.brown,),
                  customitemDashBoard( title: 'Revenue', iconData:  CupertinoIcons.money_dollar_circle, background:  Colors.indigo,),
                  customitemDashBoard( title: 'Upload', iconData:  CupertinoIcons.add_circled, background:  Colors.teal,),
                  customitemDashBoard( title: 'About', iconData:  CupertinoIcons.question_circle, background: Colors.blue,),
                  customitemDashBoard( title: 'Contact', iconData:  CupertinoIcons.phone, background:  Colors.pinkAccent,),
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


