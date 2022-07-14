// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'search_by_widget.dart';

class MyDataTableDemo extends StatefulWidget {
  const MyDataTableDemo({Key? key}) : super(key: key);

  @override
  State<MyDataTableDemo> createState() => _MyDataTableDemoState();
}

class _MyDataTableDemoState extends State<MyDataTableDemo> {
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  void dispose() {
    rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
    super.dispose();
  }

  late final ProductTableDataSource _data;

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void _sort<T>(Comparable<T> Function(ProductModel d) getField,
      int columnIndex, bool ascending) {
    _data._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void initState() {
    _data = ProductTableDataSource(
      context,
      ProductModel.fakeData,
      onPressed: () {
        toast('Hello world!');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SearchByWidget(
            listOfCategories: ProductModel.fieldStrings,
            withCategory: true,
            onSearchTextChanged: (String text) {},
            onChanged: (String category) {},
            onBothChanged: (String category, String text) {},
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Expanded(
                  child: PaginatedDataTable(
                    header: const Text('Products Table'),
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    showCheckboxColumn: false,
                    columns: [
                      const DataColumn(
                        label: Text('ID'),
                        tooltip: 'ID',
                      ),
                      const DataColumn(
                        label: Text('Barcode'),
                        tooltip: 'Barcode',
                      ),
                      DataColumn(
                        label: const Text('Product Name'),
                        tooltip: 'Product Name',
                        onSort: (int columnIndex, bool ascending) {
                          _sort<String>((ProductModel d) => d.productName,
                              columnIndex, ascending);
                        },
                      ),
                      const DataColumn(
                        label: Text('Price In'),
                        tooltip: 'Price In',
                      ),
                      const DataColumn(
                        label: Text('Price Out'),
                        tooltip: 'Price Out',
                      ),
                      const DataColumn(
                        label: Text('Quantity'),
                        tooltip: 'Quantity',
                      ),
                      const DataColumn(
                        label: Text('Category'),
                        tooltip: 'Category',
                      ),
                      const DataColumn(
                        label: Text('Date In'),
                        tooltip: 'Date In',
                      ),
                      const DataColumn(
                        label: Text('Suplier'),
                        tooltip: 'Suplier',
                      ),
                      const DataColumn(
                        label: Text('Description'),
                        tooltip: 'Description',
                      ),
                    ],
                    source: _data,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductTableDataSource extends DataTableSource {
  ProductTableDataSource(this.context, this.products, {this.onPressed})
      : _rows = products;
  final void Function()? onPressed;
  final BuildContext context;
  List<ProductModel> _rows = [];
  List<ProductModel> products = [];

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return const DataRow(cells: []);
    final row = _rows[index];
    return DataRow.byIndex(
        index: index,
        selected: row.selected,
        onSelectChanged: (value) {
          if (row.selected != value) {
            _selectedCount += value! ? 1 : -1;
            assert(_selectedCount >= 0);
            row.selected = value;
            notifyListeners();
          }
        },
        cells: [
          DataCell(Text(row.id.toString())),
          DataCell(Text(row.barcode.toString())),
          DataCell(
              GestureDetector(onTap: onPressed, child: Text(row.productName))),
          DataCell(Text(row.priceIn.toString())),
          DataCell(Text(row.priceOut.toString())),
          DataCell(Text(row.quantity.toString())),
          DataCell(Text(row.category.toString())),
          DataCell(Text(row.dateIn.toString())),
          DataCell(Text(row.suplier.toString())),
          DataCell(Text(row.description.toString())),
        ]);
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void sort(DataColumn column, bool ascending) {
    // _rows.sort((a, b) => ascending
    //     ? a..compareTo(b.valueA)
    //     : b.valueA.compareTo(a.valueA));
    // notifyListeners();
  }

  void _sort<T>(
      Comparable<T> Function(ProductModel d) getField, bool ascending) {
    _rows.sort((ProductModel a, ProductModel b) {
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
  void _filterByCategory(String category, String text) {
    if (text.isEmpty) {
      _rows = products;
      notifyListeners();
    }
    switch (category) {
      case "ID":
        _rows =
            products.where((row) => row.id.toString().contains(text)).toList();
        notifyListeners();
        break;
      case "Barcode":
        _rows = products
            .where((row) => row.barcode.toString().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Product Name":
        _rows = products
            .where((row) => row.productName.toString().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Price In":
        _rows = products
            .where((row) => row.priceIn.toString().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Price Out":
        _rows = products
            .where((row) => row.priceOut.toString().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Quantity":
        _rows = products
            .where((row) => row.quantity.toString().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Category":
        _rows = products
            .where((row) => row.category.toString().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Date In":
        _rows = products
            .where((row) => row.dateIn.toString().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Suplier":
        _rows = products
            .where((row) => row.suplier.toString().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Description":
        _rows = products
            .where((row) => row.description.toString().contains(text))
            .toList();
        notifyListeners();
        break;
      default:
        _rows = products
            .where((row) => row.productName.toString().contains(text))
            .toList();
        notifyListeners();
        break;
    }
  }
}

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
    for (int i = 0; i < 12; i++) {
      list.add(ProductModel(
        id: '$i',
        barcode: '$i',
        productName: 'Product $i',
        description: 'Description $i',
        category: 'Category $i',
        dateIn: DateTime.now(),
        quantity: i,
        priceIn: i.toDouble(),
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
