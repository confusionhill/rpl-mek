import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sti_rpl_todo/models/kategori.model.dart';
import 'package:sti_rpl_todo/components/sidebar/sidebar.dart';
import 'package:sti_rpl_todo/service/database.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Demo');
    setWindowMinSize(const Size(700, 700));
    setWindowMaxSize(Size.infinite);
  }
  await DatabaseService.shared.onCreate();
  runApp(GetMaterialApp(home: Home()));
}

class Controller extends GetxController {
  DatabaseInterface service = DatabaseService.shared;
  var count = 0.obs;
  increment() => count++;
}

class Home extends StatelessWidget {
  final Controller c = Get.put(Controller());
  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.

    return Scaffold(
        // Use Obx(()=> to update Text() whenever count is changed.
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        drawer: SideBar(),
        body: Center(
            child: ElevatedButton(
                child: Text("Go to Other"),
                onPressed: () => Get.bottomSheet(Other()))),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: () => c.count += 1));
  }
}

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.find();
  var number = 0;
  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(
      body: Center(
          child: TextButton(
        child: Text("Back $number"),
        onPressed: () => Get.back(),
      )),
    );
  }
}
