class ProductFilter {
  int _id = 0;
  String? _name;
  String? _categoryId;

  int get id => _id;
  set id(value) => _id = value;
  String? get name => _name;
  set name(value) => _name = value;
  String? get categoryId => _categoryId;
  set categoryId(value) => _categoryId = value;

  toJson() {
    return {
      "name": (_name != null && _name.toString().isNotEmpty ? _name : "")
    };
  }
}
