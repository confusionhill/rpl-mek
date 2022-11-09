// ignore_for_file: unnecessary_this

class KategoriModel {
  final int id;
  final String name;
  final int colorCode;

  KategoriModel(this.id, this.name, this.colorCode);

  KategoriModel.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        name = item["name"],
        colorCode = item["colorCode"];

  List<Object?>? toArguments() {
    return [this.name, this.colorCode];
  }
}
