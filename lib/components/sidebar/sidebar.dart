import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sti_rpl_todo/components/sidebar/sidebarController.dart';
import 'package:sti_rpl_todo/main.dart';

import '../../service/database.dart';

class SideBar extends StatelessWidget {
  final SidebarController c =
      Get.put(SidebarController(DatabaseService.shared));
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.read_more),
            title: const Text('screen 2'),
            onTap: () {
              var view = Other();
              view.number = 9;
              Get.to(Other());
            },
          ),
        ],
      ),
    );
  }
}
