import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uitest/extentions.dart';

import '../../theme.dart';
import '../chart_data.dart';
import '../daterange.dart';
import '../enums/date_filter.dart';

part 'product_stock.dart';
part 'filtered_products.dart';

enum Availability {
  inStock,
  scarce,
  outofStock,
}

class ProductTableDataSource extends DataTableSource {
  ProductTableDataSource(
    this.context,
    this.products, {
    this.onEditPressed,
    this.onDeletePressed,
    this.onSellPressed,
  }) : productRows = products;
  //final void Function()? onPressed;
  final void Function(ProductModel)? onSellPressed;
  void Function(ProductModel)? onDeletePressed;
  void Function(ProductModel)? onEditPressed;
  final BuildContext context;
  List<ProductModel> productRows = [];
  List<ProductModel> products = [];
  //final void Function(ProductModel) onProductselcted;

  final int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    // int rowIndex = 0;
    // if (productRows.isNotEmpty) rowIndex = index + 1;
    //log('rowIndex: $rowIndex');
    assert(index >= 0);
    if (index >= productRows.length) return const DataRow(cells: []);
    final row = productRows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      // onSelectChanged: (value) {
      //   if (row.selected != value) {
      //     _selectedCount += value! ? 1 : -1;
      //     assert(_selectedCount >= 0);
      //     row.selected = value;
      //     //onProductselcted(row);
      //     notifyListeners();
      //   }
      // },
      cells: [
        // DataCell(Text(rowIndex.toString())),
        DataCell(
          Container(
            margin: const EdgeInsets.only(right: 2.0),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: row.color.withOpacity(0.5),
              //backgroundColor: AppConstants.whiteOpacity,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                row.productName.substring(0, 1),
                style: Theme.of(context).textTheme.subtitle1!,
              ),
            ),
          ),
        ),
        // DataCell(Text('$rowIndex')),
        //DataCell(Text(row.barcode.toString())),
        DataCell(
          const Icon(
            Icons.price_check_rounded,
            color: Color.fromARGB(255, 209, 156, 106),
          ),
          onTap: () {
            onSellPressed?.call(row);
          },
        ),
        DataCell(Text(
          row.productName.toString(),
          style: Theme.of(context).textTheme.headline6,
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(row.quantity.toString())),
        DataCell(Text(row.priceIn.toString())),
        DataCell(Text(row.priceOut.toString())),
        DataCell(Text(row.suplier.toString())),
        DataCell(Text(row.dateIn.ddmmyyyy())),
        DataCell(Text(row.category.toString())),
        DataCell(Text(
          row.description.toString(),
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(
            const Icon(
              Icons.edit_rounded,
            ), onTap: () {
          onEditPressed?.call(row);
        }),
        DataCell(
            const Icon(
              Icons.delete_rounded,
              color: Colors.red,
            ), onTap: () {
          onDeletePressed?.call(row);
        }),
        // DataCell(Text(row.suplier.toString())),
        // DataCell(Text(row.description.toString())),
      ],
    );
  }

  @override
  int get rowCount => productRows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void sort<T>(
      Comparable<T> Function(ProductModel d) getField, bool ascending) {
    productRows.sort((ProductModel a, ProductModel b) {
      if (!ascending) {
        final ProductModel c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  /// filtered by category
  void filterByCategory(String category, String text) {
    text = text.toLowerCase();
    if (text.isEmpty) {
      productRows = products;
      notifyListeners();
    }
    switch (category) {
      case "ID":
        productRows = products
            .where((row) => row.pId.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Barcode":
        productRows = products
            .where((row) => row.barcode.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Name":
        productRows = products
            .where((row) =>
                row.productName.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Price In":
        productRows = products
            .where((row) => row.priceIn.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Price Out":
        productRows = products
            .where(
                (row) => row.priceOut.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Quantity":
        productRows = products
            .where(
                (row) => row.quantity.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Category":
        productRows = products
            .where(
                (row) => row.category.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Date In":
        productRows = products
            .where((row) => row.dateIn.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Suplier":
        productRows = products
            .where((row) => row.suplier.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Description":
        productRows = products
            .where((row) =>
                row.description.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      default:
        productRows = products
            .where((row) =>
                row.productName.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
    }
  }
}

class ProductModel {
  String? pId;
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

  bool selected = false;

  Color get color {
    switch (quantity) {
      case 0:
        return Colors.red.shade400;
      case 1:
        return Colors.amber.shade800;
      case 2:
        return Colors.amber.shade600;
      case 3:
        return Colors.amber.shade500;
      default:
        Colors.green[300];
    }
    return MThemeData.primaryColor;
  }

  double? get priceOutTotal {
    return (priceOut * quantity);
  }

  double? get priceInTotal {
    return (priceIn * quantity);
  }

  /// check if the product is valid
  bool get isValid {
    if (pId!.isNotEmpty &&
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
    this.pId,
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
      pId: id ?? this.pId,
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

  /// Columns for the DataTable.

  Map<String, dynamic> toMap() {
    return {
      if (pId != null) 'id': pId,
      'barcode': barcode ?? '',
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

  factory ProductModel.fromMap(DocumentSnapshot map) {
    // Timestamp f = map['dateIn'];
    return ProductModel(
      pId: map.id,
      barcode: map['barcode'],
      productName: map['name'],
      description: map['description'],
      category: map['category'],
      dateIn: ((map['dateIn'])).toDate(), //f.toDate(), //
      quantity: (map['quantity']),
      priceIn: (map['priceIn']),
      priceOut: (map['priceOut']),
      suplier: map['suplier'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $pId, barcode: $barcode, name: $productName, description: $description,category: $category, dateIn: $dateIn, quantity: $quantity, priceIn: $priceIn, priceOut: $priceOut, suplier: $suplier, availability: $availability)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.pId == pId &&
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
    return pId.hashCode ^
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

  /// fake data
  static List<ProductModel> get fakeData {
    var list = <ProductModel>[];

    for (int j = 0; j < 12; j++) {
      list.add(ProductModel(
        pId: 'id$j',
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
        pId: '$i',
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
}
