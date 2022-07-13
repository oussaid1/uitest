// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class DataTableDemo extends StatefulWidget {
  const DataTableDemo({Key? key}) : super(key: key);

  @override
  State<DataTableDemo> createState() => _DataTableDemoState();
}

class _RestorableDessertSelections extends RestorableProperty<Set<int>> {
  Set<int> _dessertSelections = {};

  /// Returns whether or not a dessert row is selected by index.
  bool isSelected(int index) => _dessertSelections.contains(index);

  /// Takes a list of [_Dessert]s and saves the row indices of selected rows
  /// into a [Set].
  void setDessertSelections(List<_Dessert> desserts) {
    final updatedSet = <int>{};
    for (var i = 0; i < desserts.length; i += 1) {
      var dessert = desserts[i];
      if (dessert.selected) {
        updatedSet.add(i);
      }
    }
    _dessertSelections = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _dessertSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _dessertSelections = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _dessertSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _dessertSelections = value;
  }

  @override
  Object toPrimitives() => _dessertSelections.toList();
}

class _DataTableDemoState extends State<DataTableDemo> with RestorationMixin {
  final _RestorableDessertSelections _dessertSelections =
      _RestorableDessertSelections();
  final RestorableInt _rowIndex = RestorableInt(0);
  final RestorableInt _rowsPerPage =
      RestorableInt(PaginatedDataTable.defaultRowsPerPage);
  final RestorableBool _sortAscending = RestorableBool(true);
  final RestorableIntN _sortColumnIndex = RestorableIntN(null);
  _DessertDataSource? _dessertsDataSource;

  @override
  String get restorationId => 'data_table_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_dessertSelections, 'selected_row_indices');
    registerForRestoration(_rowIndex, 'current_row_index');
    registerForRestoration(_rowsPerPage, 'rows_per_page');
    registerForRestoration(_sortAscending, 'sort_ascending');
    registerForRestoration(_sortColumnIndex, 'sort_column_index');

    _dessertsDataSource ??= _DessertDataSource(context);
    switch (_sortColumnIndex.value) {
      case 0:
        _dessertsDataSource!._sort<String>((d) => d.name, _sortAscending.value);
        break;
      case 1:
        _dessertsDataSource!
            ._sort<num>((d) => d.calories, _sortAscending.value);
        break;
      case 2:
        _dessertsDataSource!._sort<num>((d) => d.fat, _sortAscending.value);
        break;
      case 3:
        _dessertsDataSource!._sort<num>((d) => d.carbs, _sortAscending.value);
        break;
      case 4:
        _dessertsDataSource!._sort<num>((d) => d.protein, _sortAscending.value);
        break;
      case 5:
        _dessertsDataSource!._sort<num>((d) => d.sodium, _sortAscending.value);
        break;
      case 6:
        _dessertsDataSource!._sort<num>((d) => d.calcium, _sortAscending.value);
        break;
      case 7:
        _dessertsDataSource!._sort<num>((d) => d.iron, _sortAscending.value);
        break;
    }
    _dessertsDataSource!.updateSelectedDesserts(_dessertSelections);
    _dessertsDataSource!.addListener(_updateSelectedDessertRowListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dessertsDataSource ??= _DessertDataSource(context);
    _dessertsDataSource!.addListener(_updateSelectedDessertRowListener);
  }

  void _updateSelectedDessertRowListener() {
    _dessertSelections.setDessertSelections(_dessertsDataSource!._desserts);
  }

  void _sort<T>(
    Comparable<T> Function(_Dessert d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dessertsDataSource!._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex.value = columnIndex;
      _sortAscending.value = ascending;
    });
  }

  @override
  void dispose() {
    _rowsPerPage.dispose();
    _sortColumnIndex.dispose();
    _sortAscending.dispose();
    _dessertsDataSource!.removeListener(_updateSelectedDessertRowListener);
    _dessertsDataSource!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final localizations = GalleryLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("demoDataTableTitle"),
      ),
      body: Scrollbar(
        child: ListView(
          restorationId: 'data_table_list_view',
          padding: const EdgeInsets.all(16),
          children: [
            PaginatedDataTable(
              header: const Text("dataTableHeader"),
              rowsPerPage: _rowsPerPage.value,
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage.value = value!;
                });
              },
              initialFirstRowIndex: _rowIndex.value,
              onPageChanged: (rowIndex) {
                setState(() {
                  _rowIndex.value = rowIndex;
                });
              },
              sortColumnIndex: _sortColumnIndex.value,
              sortAscending: _sortAscending.value,
              onSelectAll: _dessertsDataSource!._selectAll,
              columns: [
                DataColumn(
                  label: const Text("dataTableColumnDessert"),
                  onSort: (columnIndex, ascending) =>
                      _sort<String>((d) => d.name, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text("dataTableColumnCalories"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.calories, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text("dataTableColumnFat"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.fat, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text("dataTableColumnCarbs"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.carbs, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text("dataTableColumnProtein"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.protein, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text("dataTableColumnSodium"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.sodium, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text("dataTableColumnCalcium"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.calcium, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text("dataTableColumnIron"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.iron, columnIndex, ascending),
                ),
              ],
              source: _dessertsDataSource!,
            ),
          ],
        ),
      ),
    );
  }
}

class _Dessert {
  _Dessert(
    this.name,
    this.calories,
    this.fat,
    this.carbs,
    this.protein,
    this.sodium,
    this.calcium,
    this.iron,
  );

  final String name;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  final int sodium;
  final int calcium;
  final int iron;
  bool selected = false;
}

class _DessertDataSource extends DataTableSource {
  _DessertDataSource(this.context) {
    //final localizations = GalleryLocalizations.of(context)!;
    _desserts = <_Dessert>[
      // _Dessert(
      //   "FrozenYogurt",
      //   159,
      //   6.0,
      //   24,
      //   4.0,
      //   87,
      //   14,
      //   1,
      // ),
      // _Dessert(
      //   "IceCreamSandwich",
      //   237,
      //   9.0,
      //   37,
      //   4.3,
      //   129,
      //   8,
      //   1,
      // ),
      _Dessert(
        "Eclair",
        262,
        16.0,
        24,
        6.0,
        337,
        6,
        7,
      ),
      _Dessert(
        "Cupcake",
        305,
        3.7,
        67,
        4.3,
        413,
        3,
        8,
      ),
      _Dessert(
        "Gingerbread",
        356,
        16.0,
        49,
        3.9,
        327,
        7,
        16,
      ),
      _Dessert(
        "JellyBean",
        375,
        0.0,
        94,
        0.0,
        50,
        0,
        0,
      ),
      _Dessert(
        "Lollipop",
        392,
        0.2,
        98,
        0.0,
        38,
        0,
        2,
      ),
      _Dessert(
        "Honeycomb",
        408,
        3.2,
        87,
        6.5,
        562,
        0,
        45,
      ),
      _Dessert(
        "Donut",
        452,
        25.0,
        51,
        4.9,
        326,
        2,
        22,
      ),
      _Dessert(
        "ApplePie",
        518,
        26.0,
        65,
        7.0,
        54,
        12,
        6,
      ),
      _Dessert(
        "WithSugar",
        168,
        6.0,
        26,
        4.0,
        87,
        14,
        1,
      ),
      _Dessert(
        "WithSugar",
        246,
        9.0,
        39,
        4.3,
        129,
        8,
        1,
      ),
      _Dessert(
        "WithSugar",
        271,
        16.0,
        26,
        6.0,
        337,
        6,
        7,
      ),
      _Dessert(
        "WithSugar",
        314,
        3.7,
        69,
        4.3,
        413,
        3,
        8,
      ),
      _Dessert(
        "WithSugar",
        345,
        16.0,
        51,
        3.9,
        327,
        7,
        16,
      ),
      _Dessert(
        "WithSugar",
        364,
        0.0,
        96,
        0.0,
        50,
        0,
        0,
      ),
      _Dessert(
        "WithSugar",
        401,
        0.2,
        100,
        0.0,
        38,
        0,
        2,
      ),
      _Dessert(
        "WithSugar",
        417,
        3.2,
        89,
        6.5,
        562,
        0,
        45,
      ),
      _Dessert(
        "WithSugar",
        461,
        25.0,
        53,
        4.9,
        326,
        2,
        22,
      ),
      _Dessert(
        "WithSugar",
        527,
        26.0,
        67,
        7.0,
        54,
        12,
        6,
      ),
      _Dessert(
        "WithHoney",
        223,
        6.0,
        36,
        4.0,
        87,
        14,
        1,
      ),
      _Dessert(
        "WithHoney",
        301,
        9.0,
        49,
        4.3,
        129,
        8,
        1,
      ),
      _Dessert(
        "WithHoney",
        326,
        16.0,
        36,
        6.0,
        337,
        6,
        7,
      ),
      _Dessert(
        "WithHoney",
        369,
        3.7,
        79,
        4.3,
        413,
        3,
        8,
      ),
      _Dessert(
        "WithHoney",
        420,
        16.0,
        61,
        3.9,
        327,
        7,
        16,
      ),
      _Dessert(
        "WithHoney",
        439,
        0.0,
        106,
        0.0,
        50,
        0,
        0,
      ),
      _Dessert(
        "WithHoney",
        456,
        0.2,
        110,
        0.0,
        38,
        0,
        2,
      ),
      _Dessert(
        "WithHoney",
        472,
        3.2,
        99,
        6.5,
        562,
        0,
        45,
      ),
      _Dessert(
        "WithHoney",
        516,
        25.0,
        63,
        4.9,
        326,
        2,
        22,
      ),
      _Dessert(
        "WithHoney",
        582,
        26.0,
        77,
        7.0,
        54,
        12,
        6,
      ),
    ];
  }

  final BuildContext context;
  late List<_Dessert> _desserts;

  void _sort<T>(Comparable<T> Function(_Dessert d) getField, bool ascending) {
    _desserts.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  void updateSelectedDesserts(_RestorableDessertSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < _desserts.length; i += 1) {
      var dessert = _desserts[i];
      if (selectedRows.isSelected(i)) {
        dessert.selected = true;
        _selectedCount += 1;
      } else {
        dessert.selected = false;
      }
    }
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    // final format = NumberFormat.decimalPercentPattern(
    //   locale: GalleryOptions.of(context).locale.toString(),
    //   decimalDigits: 0,
    // );
    assert(index >= 0);
    if (index >= _desserts.length) return null;
    final dessert = _desserts[index];
    return DataRow.byIndex(
      index: index,
      selected: dessert.selected,
      onSelectChanged: (value) {
        if (dessert.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(dessert.name)),
        DataCell(Text('${dessert.calories}')),
        DataCell(Text(dessert.fat.toStringAsFixed(1))),
        DataCell(Text('${dessert.carbs}')),
        DataCell(Text(dessert.protein.toStringAsFixed(1))),
        DataCell(Text('${dessert.sodium}')),
        DataCell(Text(100.toRadixString(2))),
        DataCell(Text(100.toRadixString(2))),
      ],
    );
  }

  @override
  int get rowCount => _desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool? checked) {
    for (final dessert in _desserts) {
      dessert.selected = checked ?? false;
    }
    _selectedCount = checked! ? _desserts.length : 0;
    notifyListeners();
  }
}

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PaginatedDataTable(
            header: const Text('Products Table'),
            //rowsPerPage: 10,
            // onRowsPerPageChanged: (int? value) {
            //   setState(() {
            //     log('rowsPerPage: $value');
            //     rowsPerPage = value ?? rowsPerPage;
            //   });
            // },
            columns: ProductModel.columns,
            source: ProductTableDataSource(context, onPressed: () {
              toast('Hello world!');
            }),
          ),
        ],
      ),
    );
  }
}

class ProductTableDataSource extends DataTableSource {
  ProductTableDataSource(this.context, {this.onPressed}) {
    // _rows.clear();
    _rows = ProductModel.fakeData;
  }
  final void Function()? onPressed;
  final BuildContext context;
  List<ProductModel> _rows = [];

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
          DataCell(
              GestureDetector(onTap: onPressed, child: Text(row.productName))),
          DataCell(Text(row.priceIn.toString())),
          DataCell(Text(row.priceOut.toString())),
          DataCell(Text(row.quantity.toString())),
          DataCell(Text(row.dateIn.toString())),
          DataCell(Text(row.barcode.toString())),
          DataCell(Text(row.category.toString())),
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

  /// Columns for the DataTable.
  static const columns = [
    DataColumn(
      label: Text('ID'),
      tooltip: 'ID',
    ),
    DataColumn(
      label: Text('Barcode'),
      tooltip: 'Barcode',
    ),
    DataColumn(
      label: Text('Product Name'),
      tooltip: 'Product Name',
    ),
    DataColumn(
      label: Text('Description'),
      tooltip: 'Description',
    ),
    DataColumn(
      label: Text('Category'),
      tooltip: 'Category',
    ),
    DataColumn(
      label: Text('Date In'),
      tooltip: 'Date In',
    ),
    DataColumn(
      label: Text('Quantity'),
      tooltip: 'Quantity',
    ),
    DataColumn(
      label: Text('Price In'),
      tooltip: 'Price In',
    ),
    DataColumn(
      label: Text('Price Out'),
      tooltip: 'Price Out',
    ),
    DataColumn(
      label: Text('Suplier'),
      tooltip: 'Suplier',
    ),
  ];

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
