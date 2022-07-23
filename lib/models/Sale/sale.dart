import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:uitest/extentions.dart';
import 'package:uitest/models/daterange.dart';

import '../enums/date_filter.dart';
import '../models.dart';
import 'product_sales_data.dart';
import 'service_sales_data.dart';

part 'filtered_product_sales.dart';
part 'filtered_sales.dart';
part 'filtered_service_sales.dart';
part 'sales_data.dart';

enum SaleType { product, service, all }

class SaleTableDataSource extends DataTableSource {
  SaleTableDataSource(
    this.context,
    this.sales, {
    this.onEditPressed,
    this.onDeletePressed,
    this.onUnSellPressed,
  }) : saleRows = sales;
  //final void Function()? onPressed;
  final void Function(SaleModel)? onUnSellPressed;
  void Function(SaleModel)? onDeletePressed;
  void Function(SaleModel)? onEditPressed;
  final BuildContext context;
  List<SaleModel> saleRows = [];
  List<SaleModel> sales = [];

  final int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    // int rowIndex = 0;
    // if (productRows.isNotEmpty) rowIndex = index + 1;
    //log('rowIndex: $rowIndex');
    assert(index >= 0);
    if (index >= saleRows.length) return const DataRow(cells: []);
    final row = saleRows[index];
    return DataRow.byIndex(
      //color: MaterialStateProperty.resolveAs  ,
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
              color: row.saleQualityColor.withOpacity(0.5),
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
            Icons.money_off_outlined,
            color: Color.fromARGB(255, 209, 156, 106),
          ),
          onTap: () {
            onUnSellPressed?.call(row);
          },
        ),
        DataCell(Text(
          row.productName.toString(),
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(row.quantitySold.toString())),
        DataCell(Text(row.priceIn.toString())),
        DataCell(Text(row.priceOut.toString())),
        DataCell(Text((row.suplier ?? ''))),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(row.totalPriceSoldFor.toString()),
            Text(
              row.priceSoldFor.toString(),
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        )),
        DataCell(Text(row.dateSold.ddmmyyyy())),
        DataCell(Text(row.category ?? '')),
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
  int get rowCount => saleRows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void sort<T>(Comparable<T> Function(SaleModel d) getField, bool ascending) {
    saleRows.sort((SaleModel a, SaleModel b) {
      if (!ascending) {
        final SaleModel c = a;
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
      saleRows = sales;
      notifyListeners();
    }
    switch (category) {
      case "ID":
        saleRows = sales
            .where((row) => row.pId.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Barcode":
        saleRows = sales
            .where((row) => row.barcode.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Name":
        sales
            .where((row) =>
                row.productName.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Price In":
        saleRows = sales
            .where((row) => row.priceIn.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Price Out":
        saleRows = sales
            .where(
                (row) => row.priceOut.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Quantity":
        saleRows = sales
            .where((row) =>
                row.quantitySold.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;

      case "Date In":
        saleRows = sales
            .where(
                (row) => row.dateSold.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Suplier":
        saleRows = sales
            .where((row) => row.suplier.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Description":
        saleRows = sales
            .where((row) =>
                row.description.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      default:
        saleRows = sales
            .where((row) =>
                row.productName.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
    }
  }
}

class SaleModel extends ProductModel {
  String? saleId;
  String productId;
  String shopClientId;
  DateTime dateSold;
  int quantitySold;
  double priceSoldFor;
  SaleType? type;
  String? saleDescription;
  ////////////////////////////////////////////////
  ///Constructors /////////

  SaleModel({
    this.saleId,
    required this.productId,
    required this.shopClientId,
    required this.dateSold,
    required this.quantitySold,
    required this.priceSoldFor,
    required this.type,
    this.saleDescription,
    ProductModel? product,
  }) : super(
          pId: product?.pId,
          barcode: product?.barcode ?? '',
          productName: product?.productName ?? '',
          description: product?.description ?? '',
          category: product?.category ?? '',
          dateIn: product?.dateIn ?? DateTime.now(),
          quantity: product?.quantity ?? 0,
          priceIn: product?.priceIn ?? 0,
          priceOut: product?.priceOut ?? 0,
          suplier: product?.suplier ?? '',
        );
  ////////////////////////////////////////////////
  ///Methods /////////

  /// copywith for the sale model only
  SaleModel copySaleWith({
    String? saleId,
    String? productId,
    String? shopClientId,
    int? quantitySold,
    DateTime? dateSold,
    double? priceSoldFor,
    String? saleDescription,
    SaleType? type,
  }) {
    return SaleModel(
      saleId: saleId ?? this.saleId,
      productId: productId ?? this.productId,
      shopClientId: shopClientId ?? this.shopClientId,
      dateSold: dateSold ?? this.dateSold,
      quantitySold: quantitySold ?? this.quantitySold,
      priceSoldFor: priceSoldFor ?? this.priceSoldFor,
      type: type,
      saleDescription: saleDescription ?? this.saleDescription,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      //if (saleId != null) 'saleId': saleId,
      'productId': productId,
      'shopClientId': shopClientId,
      'dateSold': dateSold,
      'quantitySold': quantitySold,
      'priceSoldFor': priceSoldFor,
      'type': type.toString(),
      'saleDescription': saleDescription,
    };
  }

  factory SaleModel.fromMap(DocumentSnapshot map) {
    final type = map['type'].toString().split('.').last == 'product'
        ? SaleType.product
        : SaleType.service;
    // print(map['type']);
    return SaleModel(
      saleId: map.id,
      productId: map['productId'] ?? '',
      shopClientId: map['shopClientId'] ?? '',
      dateSold: map['dateSold'].toDate() ?? DateTime.now(),
      quantitySold: map['quantitySold'] ?? 0,
      priceSoldFor: map['priceSoldFor'] ?? 0,
      saleDescription: map['saleDescription'] ?? '',
      type: type,
    );
  }
  ////////////////////////////////////////////////
  /// get reduced quantity /////////
  int get reducedQuantity {
    return quantity - quantitySold;
  }

  /// build total quantity  /////////
  int get totalQuantity {
    return quantity + quantitySold;
  }

  double get totalPriceSoldFor {
    return (priceSoldFor * quantitySold);
  }

  bool saleSelected = false;
// get the auality of sale acoording to price sod for in comparison with price in
  int get saleQuality {
    if (totalPriceSoldFor < priceIn) {
      return -1;
    } else if (totalPriceSoldFor > priceIn) {
      return 1;
    }
    return 0;
  }

  // get the color of the sale quality
  Color get saleQualityColor {
    if (saleQuality == -1) {
      return Colors.red;
    } else if (saleQuality == 1) {
      return const Color.fromARGB(255, 42, 114, 78);
    }
    return Colors.orange;
  }

  double get totalPriceIn {
    var total = 0.0;
    total += (priceIn * quantitySold);
    return total;
  }

  double get profitMargin {
    var net = 0.0;
    net += (totalPriceSoldFor - totalPriceIn);
    return net;
  }

  double get totalPriceOut {
    var total = 0.0;
    total += (priceOut * quantitySold);
    return total;
  }

  /// get fields as list of strings
  static const List<String> fieldStrings = [
    'soldItemId',
    'dateSold',
    'quantitySold',
    'itemSoldTitle',
    'shopClientId',
    'priceSoldFor',
    'priceIn',
    'priceOut',
    'type',
    'barcode',
    'description',
    'count',
  ];

  @override
  String toJson() => json.encode(toMap());

  factory SaleModel.fromJson(String source) =>
      SaleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SaleModel(id: $saleId, productId: $productId, shopClientId: $shopClientId , dateSold: $dateSold, quantitySold: $quantitySold, priceSoldFor: $priceSoldFor, type: $type, saleDescription: $saleDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SaleModel &&
        other.saleId == saleId &&
        other.productId == productId &&
        other.shopClientId == shopClientId &&
        other.dateSold == dateSold &&
        other.quantitySold == quantitySold &&
        other.priceSoldFor == priceSoldFor &&
        other.type == type &&
        other.saleDescription == saleDescription;
  }

  @override
  int get hashCode {
    return pId.hashCode ^
        productId.hashCode ^
        shopClientId.hashCode ^
        dateSold.hashCode ^
        quantitySold.hashCode ^
        priceSoldFor.hashCode ^
        priceIn.hashCode ^
        priceOut.hashCode ^
        type.hashCode ^
        barcode.hashCode ^
        suplier.hashCode ^
        category.hashCode ^
        description.hashCode;
  }
}
