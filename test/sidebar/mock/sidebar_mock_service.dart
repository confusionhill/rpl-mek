import 'package:sti_rpl_todo/models/kategori.model.dart';
import 'package:sti_rpl_todo/service/database.dart';

class SidebarMockDBService implements DatabaseInterface {
  var getKategoriesCalled = false;
  @override
  Future<List<KategoriModel>> getKategories() async {
    getKategoriesCalled = true;
    return [];
  }

  var didInsertGetCalled = false;
  @override
  Future insertKategori(KategoriModel kategori) async {
    didInsertGetCalled = true;
  }
}
