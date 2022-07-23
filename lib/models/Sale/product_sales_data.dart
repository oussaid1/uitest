import 'sale.dart';

class ProductSalesData {
  List<SaleModel> sales = [];
  ProductSalesData({
    required this.sales,
  });

  /// get the sales list of products
  List<SaleModel> get productSalesList =>
      sales.where((element) => element.type == SaleType.product).toList();

  /// total sales of products
  int get totalProductSalesCount => productSalesList.fold(
      0, (previousValue, element) => previousValue + element.quantitySold);

  /// total soldfor of products
  double get totalProductSalesFor => productSalesList.fold(
      0, (previousValue, element) => previousValue + element.priceSoldFor);
}
