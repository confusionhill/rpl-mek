import 'package:get/get.dart';
import 'package:sti_rpl_todo/models/kategori.model.dart';
import 'package:sti_rpl_todo/service/database.dart';

class SidebarController extends GetxController {
  DatabaseInterface service;
  SidebarController(this.service);
  RxList<KategoriModel> kategoriList = <KategoriModel>[].obs;
  void loadKategori() async {
    (await service.getKategories()).forEach((element) {
      kategoriList.add(element);
    });
  }
}
