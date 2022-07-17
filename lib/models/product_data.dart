import '../widgets/charts.dart';
import 'product.dart';

class ProductData {
  List<ProductModel> products;
  ProductData({required this.products});

  /// get a list of products sorted by date in
  List<ProductModel> get sortedProducts {
    return products.toList()..sort((a, b) => a.dateIn.compareTo(b.dateIn));
  }

  /// get a map of sum of products prices for each day
  /// key is date in, value is sum of prices in
  Map<DateTime, double> get pricesByDay {
    Map<DateTime, double> pricesByDay = {};
    for (ProductModel product in sortedProducts) {
      pricesByDay[product.dateIn] ??= 0.0;
      pricesByDay[product.dateIn] =
          pricesByDay[product.dateIn]! + product.priceIn;
    }
    return pricesByDay;
  }

  /// get a map of sum of products prices for each month
  /// key is month in, value is sum of prices in
  Map<DateTime, double> get pricesByMonth {
    Map<DateTime, double> pricesByMonth = {};
    for (ProductModel product in sortedProducts) {
      pricesByMonth[DateTime(00, product.dateIn.month, product.dateIn.year)] ??=
          0.0;
      pricesByMonth[DateTime(00, product.dateIn.month, product.dateIn.year)] =
          pricesByMonth[
                  DateTime(00, product.dateIn.month, product.dateIn.year)]! +
              product.priceIn;
    }
    return pricesByMonth;
  }

  /// get a map of sum of products prices for each year
  /// key is year in, value is sum of prices in
  Map<DateTime, double> get pricesByYear {
    Map<DateTime, double> pricesByYear = {};
    for (ProductModel product in sortedProducts) {
      pricesByYear[DateTime(product.dateIn.year, 00, 00)] ??= 0.0;
      pricesByYear[DateTime(product.dateIn.year, 00, 00)] =
          pricesByYear[DateTime(product.dateIn.year, 00, 00)]! +
              product.priceIn;
    }
    return pricesByYear;
  }

  /// get a list of ChartData for each day
  List<ChartData> get chartDataDDMMYY {
    return pricesByDay.entries.map((entry) {
      return ChartData(entry.key.toString(), entry.value, entry.key);
    }).toList();
  }

  /// get a list of ChartData for each month
  List<ChartData> get chartDataMMYY {
    return pricesByMonth.entries.map((entry) {
      return ChartData(entry.key.toString(), entry.value, entry.key);
    }).toList();
  }

  /// get a list of ChartData for each year
  /// key is year in, value is sum of prices in
  List<ChartData> get chartDataYY {
    return pricesByYear.entries.map((entry) {
      return ChartData(entry.key.toString(), entry.value, entry.key);
    }).toList();
  }

  /// get a list of ChartData for each year
  /// key is year in, value is sum of prices in
  List<ChartData> get chartDataYYMMDD {
    return pricesByYear.entries.map((entry) {
      return ChartData(entry.key.toString(), entry.value, entry.key);
    }).toList();
  }

  /// get a map of sum of products prices for category
  /// key is category, value is sum of prices in
  Map<String, double> get pricesByCategory {
    Map<String, double> pricesByCategory = {};
    for (ProductModel product in sortedProducts) {
      pricesByCategory[product.category!] ??= 0.0;
      pricesByCategory[product.category!] =
          pricesByCategory[product.category]! + product.priceIn;
    }
    return pricesByCategory;
  }

  /// get a list of ChartData from a map parameter
  List<ChartData> chartData(map) {
    return map.map((entry) {
      return ChartData(entry.key, entry.value, DateTime.now());
    }).toList();
  }

  /// get a list of ChartData from a map parameter
  List<ChartData> get chartDataByCategory {
    return pricesByCategory.entries.map((entry) {
      return ChartData(entry.key, entry.value, DateTime.now());
    }).toList();
  }
}

//var productsData = {Category 0: 2.0, Category 1: 0.0, Category 2: 0.0, Category 3: 0.0, Category 4: 2.0, Category 5: 2.0, Category 6: 2.0, Category 7: 0.0, Category 8: 0.0, Category 9: 0.0, Category 10: 2.0, Category 11: 2.0, category0: 34.0, category1: 152.0, category2: 120.0, category3: 127.0, category4: 4.0, category5: 129.0, category6: 28.0, category7: 107.0, category8: 168.0, category9: 189.0, category10: 87.0, category11: 112.0};