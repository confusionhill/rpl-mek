import 'package:flutter_test/flutter_test.dart';
import 'package:sti_rpl_todo/components/sidebar/sidebarController.dart';

import 'mock/sidebar_mock_service.dart';

void main() {
  test("Sidebar Controller", () {
    var service = SidebarMockDBService();
    var controller = SidebarController(service);
    controller.loadKategori();
    expect(service.getKategoriesCalled, true);
  });
}
