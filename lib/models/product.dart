import 'dart:math';

enum Availability {
  inStock,
  scarce,
  outofStock,
}

class ProductModel {
  bool selected = false;
  String? id;
  String? barcode;
  String productName;
  String? description;
  String? category;
  DateTime dateIn;
  int quantity;
  int count = 1;
  double priceIn;
  double priceOut;
  String? suplier;
  get availability {
    switch (quantity) {
      case 1:
        return Availability.scarce;
      case 0:
        return Availability.outofStock;

      default:
        return Availability.inStock;
    }
  }

  double? get priceOutTotal {
    return (priceOut * quantity);
  }

  double? get priceInTotal {
    return (priceIn * quantity);
  }

  bool get isValid {
    if (id!.isNotEmpty &&
        barcode == barcode &&
        productName.isNotEmpty &&
        quantity.isFinite &&
        priceIn == priceIn &&
        priceOut == priceOut &&
        suplier == suplier) {}
    return false;
  }

  /// get fields as list of strings
  static const List<String> fieldStrings = [
    "Barcode",
    "Name",
    "Description",
    "Category",
    "Date",
    "Quantity",
    "Price In",
    "Price Out",
    "Suplier",
  ];
  ProductModel({
    this.id,
    this.barcode,
    required this.productName,
    this.description,
    this.category,
    required this.dateIn,
    required this.quantity,
    required this.priceIn,
    required this.priceOut,
    this.suplier,
  });

  ProductModel copyWith({
    String? id,
    String? barcode,
    String? name,
    String? description,
    String? category,
    DateTime? dateIn,
    DateTime? dateOut,
    int? quantity,
    double? priceIn,
    double? priceOut,
    String? suplier,
    String? availability,
  }) {
    return ProductModel(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      productName: name ?? productName,
      description: description ?? this.description,
      category: category ?? this.category,
      dateIn: dateIn ?? this.dateIn,
      quantity: quantity ?? this.quantity,
      priceIn: priceIn ?? this.priceIn,
      priceOut: priceOut ?? this.priceOut,
      suplier: suplier ?? this.suplier,
    );
  }

  /// Columns of the data table.
  getValue(String column) {
    switch (column) {
      case 'id':
        return id;
      case 'barcode':
        return barcode;
      case 'productName':
        return productName;
      case 'description':
        return description;
      case 'category':
        return category;
      case 'dateIn':
        return dateIn.toString();
      case 'quantity':
        return quantity.toString();
      case 'priceIn':
        return priceIn.toString();
      case 'priceOut':
        return priceOut.toString();
      case 'suplier':
        return suplier;

      default:
        return '';
    }
  }

  /// fake data
  static List<ProductModel> get fakeData {
    var list = <ProductModel>[];

    for (int j = 0; j < 12; j++) {
      list.add(ProductModel(
        id: 'id$j',
        barcode: 'barcode$j',
        productName: 'productName$j',
        description: 'description$j',
        category: 'category$j',
        dateIn: DateTime.now().add(Duration(days: j + 15)),
        quantity: j,
        priceIn: Random().nextInt(200).toDouble(),
        priceOut: j.toDouble(),
        suplier: 'suplier$j',
      ));
    }
    for (int i = 0; i < 12; i++) {
      list.add(ProductModel(
        id: '$i',
        barcode: '$i',
        productName: 'Product $i',
        description: 'Description $i',
        category: 'Category $i',
        dateIn: DateTime.now().add(Duration(
          days: i,
        )),
        quantity: i,
        priceIn: Random().nextInt(2) * 2,
        priceOut: i.toDouble(),
        suplier: 'Suplier $i',
      ));
    }

    return list;
  }

  Map<String, dynamic> toMap() {
    return {
      'barcode': barcode,
      'name': productName,
      'description': description,
      'category': category,
      'dateIn': dateIn,
      'quantity': quantity,
      'priceIn': priceIn,
      'priceOut': priceOut,
      'suplier': suplier,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, barcode: $barcode, name: $productName, description: $description,category: $category, dateIn: $dateIn, quantity: $quantity, priceIn: $priceIn, priceOut: $priceOut, suplier: $suplier, availability: $availability)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.barcode == barcode &&
        other.productName == productName &&
        other.description == description &&
        other.category == category &&
        other.dateIn == dateIn &&
        other.quantity == quantity &&
        other.priceIn == priceIn &&
        other.priceOut == priceOut &&
        other.suplier == suplier;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        barcode.hashCode ^
        productName.hashCode ^
        description.hashCode ^
        category.hashCode ^
        dateIn.hashCode ^
        quantity.hashCode ^
        priceIn.hashCode ^
        priceOut.hashCode ^
        suplier.hashCode ^
        availability.hashCode;
  }
}
