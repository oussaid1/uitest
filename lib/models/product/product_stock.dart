part of 'product.dart';

class ProductStockData {
  List<ProductModel> products;
  ProductStockData({
    required this.products,
  });
// get produsts by quantity less than int value
  List<ProductModel> getProductsLessThan(int quantity) {
    return products.where((product) => product.quantity <= quantity).toList();
  }

// products count
  int get productCountInStock {
    int mcount = 0;
    for (var element in products) {
      mcount += (element.count);
    }
    return mcount;
  }

// total product quantity of all items in stock
  int get totalProductQuantityInStock {
    int mcount = 0;
    for (var element in products) {
      mcount += (element.quantity);
    }
    return mcount;
  }

// total product priceIn of all items in stock
  double get totalPriceInInStock {
    double mcount = 0;
    for (var element in products) {
      mcount += (element.priceIn);
    }
    return mcount;
  }

// total product priceOut of all items in stock
  double get totalPriceOutInStock {
    double mcount = 0;
    for (var element in products) {
      mcount += (element.priceOut);
    }
    return mcount;
  }

// get a list of distinct categories
  List<String> get distinctCategories {
    List<String> mcategories = [];
    for (var element in products) {
      if (!mcategories.contains(element.category)) {
        mcategories.add(element.category.toString());
      }
    }
    return mcategories;
  }

// get chartData of category counts in stock
  List<ChartData> get productCategorySumCounts {
    List<ChartData> mchartData = [];
    // for (var element in distinctCategories) {
    //   mchartData.add(ChartData(
    //     //count: products.where((product) => product.category == element).length,
    //     label: element,
    //     value: products.where((product) => product.category == element).fold(
    //         0, (previousValue, element) => previousValue! + element.priceIn),
    //     count: products.where((product) => product.category == element).fold(
    //         0, (previousValue, element) => previousValue! + element.quantity),
    //   ));
    // }
    return mchartData;
  }
}
