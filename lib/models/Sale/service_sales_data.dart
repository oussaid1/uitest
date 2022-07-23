import 'sale.dart';

class TechServiceSalesData {
  List<SaleModel> sales = [];
  TechServiceSalesData({required this.sales});
  List<SaleModel> get serviceSalesList =>
      sales.where((element) => element.type == SaleType.service).toList();

  /// total sales of services
  int get totalServiceSalesCount => serviceSalesList.fold(
      0, (previousValue, element) => previousValue + element.quantitySold);

  /// total soldfor of services
  double get totalServiceSalesFor => serviceSalesList.fold(
      0, (previousValue, element) => previousValue + element.priceSoldFor);
}
