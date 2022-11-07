import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sti_rpl_todo/presentation/sidebar/sidebar.dart';
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
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
  await db.execute('''
  CREATE TABLE Product (
      id INTEGER PRIMARY KEY,
      title TEXT
  )
  ''');
  await db.insert('Product', <String, Object?>{'title': 'Product 1'});
  await db.insert('Product', <String, Object?>{'title': 'Product 1'});

  var result = await db.query('Product');
  print(" HASILNYA MEK : $result");
  await db.close();
  runApp(GetMaterialApp(home: Home()));
}

class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;
}

class Home extends StatelessWidget {
  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final Controller c = Get.put(Controller());

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

  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(
      body: Center(
          child: TextButton(
        child: Text("Back"),
        onPressed: () => Get.back(),
      )),
    );
  }
}
