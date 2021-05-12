import 'package:flutter/material.dart';
import 'package:betlog/ui/bets/pages/bets_page.dart';
import 'package:betlog/ui/stats/pages/stats_page.dart';
import 'package:betlog/ui/settings/pages/settings_page.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.title,
    required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: BetsPage(),
          icon: Icon(Icons.sports_baseball_sharp),
          title: "Bets",
        ),
        TabNavigationItem(
          page: StatsPage(),
          icon: Icon(Icons.poll_sharp),
          title: "Stats",
        ),
        TabNavigationItem(
          page: SettingsPage(),
          icon: Icon(Icons.settings),
          title: "Settings",
        ),
      ];
}
