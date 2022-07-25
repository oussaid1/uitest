// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'models/product/product.dart';
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
                PaginatedDataTable(
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
          DataCell(Text(row.pId.toString())),
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
  void filterByCategory(String category, String text) {
    if (text.isEmpty) {
      _rows = products;
      notifyListeners();
    }
    switch (category) {
      case "ID":
        _rows =
            products.where((row) => row.pId.toString().contains(text)).toList();
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
