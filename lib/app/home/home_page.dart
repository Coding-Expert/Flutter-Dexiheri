import 'package:dexiheri/app/home/account/account_page.dart';
import 'package:dexiheri/app/home/calendar/calendar_page.dart';
import 'package:dexiheri/app/home/cuppertino_home_scalford.dart';
import 'package:dexiheri/app/home/files/add_new_file.dart';
import 'package:dexiheri/app/home/entries/entries_page.dart';
import 'package:dexiheri/app/home/files/fakeloi_katastimatos.dart';
import 'package:dexiheri/app/home/files/add_new_file.dart';
import 'package:dexiheri/app/home/entries/entries_page.dart';
import 'package:dexiheri/app/home/files/add_new_file.dart';
import 'package:dexiheri/app/home/jobs/jobs_page.dart';
import 'package:dexiheri/app/home/tab_item.dart';
import 'package:dexiheri/app/models/user.dart';
import 'package:dexiheri/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;
  Xristis xristis;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getAuthUser();
  }

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.calendar: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.addFile: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    final database = Provider.of<Database>(context, listen: false);

    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.calendar: (_) => CalendarPage(),
      TabItem.entries: (_) => FakeloiKatastimatos(),
      TabItem.addFile: (_) => NewFile(database: database),
      TabItem.account: (_) => AccountPage(database: database),
    };
  }

  void _select(TabItem tabItem) {
    if(tabItem == _currentTab){
      //pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectedTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }



  /*Widget _getAuthUser(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Xristis>>(
      stream: database.xristisStream(),
      builder: (context , snapshot) {
        //return
      },
    );
  }*/
}
