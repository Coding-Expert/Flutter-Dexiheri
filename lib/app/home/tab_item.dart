import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/linecons_icons.dart';


enum TabItem {jobs, calendar, addFile, entries,  account }

class TabItemData{
  const TabItemData({ @required this.title, @required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem,TabItemData> allTabs = {
    TabItem.jobs: TabItemData(title: 'Καταστήματα', icon: Linecons.shop),
    TabItem.calendar: TabItemData(title: 'Ημερολόγιο', icon: Linecons.calendar),
    TabItem.addFile: TabItemData(title: 'Προσθήκη', icon: LineariconsFree.file_add),
    TabItem.entries: TabItemData(title: 'Έγγραφα', icon: FontAwesome.docs),
    TabItem.account: TabItemData(title: 'Προφίλ', icon: Icons.account_circle),
  };
}