part of 'product.dart';

class FilteredProduct {
  List<ProductModel> products = [];
  final DateFilter filterType;
  final MDateRange? dateRange;
  FilteredProduct({
    required this.products,
    this.filterType = DateFilter.all,
    this.dateRange,
  }); //: productsfilteredByCat = products;
  List<ProductModel> productsfilteredByCat = [];

  /// get distinct product names from products list
  List<String> get distinctproductName {
    List<String> mlist = [];
    for (var element in products) {
      mlist.add(element.productName);
    }
    return mlist.toSet().toList();
  }

  /// get products filtered by filter type
  List<ProductModel> get productsByFilterType {
    switch (filterType) {
      case DateFilter.all:
        return products;
      case DateFilter.month:
        return productsfilteredByCat;
      case DateFilter.custom:
        return productsByDateRange(dateRange: dateRange!);
      default:
        return products;
    }
  }

  /// filter products by category
  filterByCategory(String category, String filterText) {
    switch (category) {
      case 'All':
        productsfilteredByCat = products
            .where((element) => element.productName
                .toLowerCase()
                .contains(filterText.toLowerCase()))
            .toList();
        break;
      case 'Barcode':
        productsfilteredByCat = products
            .where((element) => element.barcode!
                .toLowerCase()
                .contains(filterText.toLowerCase()))
            .toList();
        break;
      case 'Name':
        productsfilteredByCat = products
            .where((element) => element.productName
                .toLowerCase()
                .contains(filterText.toLowerCase()))
            .toList();
        break;
      case 'Description':
        productsfilteredByCat = products
            .where((element) => element.description!
                .toLowerCase()
                .contains(filterText.toLowerCase()))
            .toList();
        break;
      case 'Category':
        productsfilteredByCat = products
            .where((element) => element.category!
                .toLowerCase()
                .contains(filterText.toLowerCase()))
            .toList();
        break;
      case 'Date':
        productsfilteredByCat = products
            .where((element) => element.dateIn
                .ddmmyyyy()
                .toLowerCase()
                .contains(filterText.toLowerCase()))
            .toList();
        break;
      case 'Quantity':
        productsfilteredByCat = products
            .where((element) => element.quantity
                .toString()
                .toLowerCase()
                .contains(filterText.toLowerCase()))
            .toList();
        break;
      case 'Price In':
        productsfilteredByCat = products
            .where((element) => element.priceIn
                .toString()
                .toLowerCase()
                .contains(filterText.toLowerCase()))
            .toList();
        break;
      case 'Price Out':
        productsfilteredByCat = products
            .where((element) => element.priceOut
                .toString()
                .toLowerCase()
                .contains(filterText.toLowerCase()))
            .toList();
        break;
      case 'Suplier':
        productsfilteredByCat = products
            .where((element) => element.suplier
                .toString()
                .toLowerCase()
                .contains(filterText.toLowerCase()))
            .toList();
        break;

      default:
        productsfilteredByCat =
            products.where((element) => element.category == category).toList();
        break;
    }
  }

  /// get distinct category
  List<String> get distinctCategories {
    List<String> mlist = [];
    for (var element in products) {
      mlist.add(element.category!);
    }
    return mlist.toSet().toList();
  }

  double get totalPriceInStock {
    double mcount = 0;
    for (var element in products) {
      mcount += (element.priceIn);
    }
    return mcount;
  }

  double get totalPriceOutStock {
    double mcount = 0;
    for (var element in products) {
      mcount += (element.priceOutTotal!);
    }
    return mcount;
  }

  productsLessThanQuantity(int quantity) {
    List<ProductModel> mlist = [];
    for (var element in products) {
      if (element.quantity < quantity) {
        mlist.add(element);
      }
    }
    return mlist;
  }

  List<ProductModel> get productsByName {
    List<ProductModel> mlist = [];
    for (var element in products) {
      mlist.add(element);
    }
    return mlist;
  }

  List<ProductModel> get productsThisMonth {
    List<ProductModel> mlist = [];
    for (var element in products) {
      if (element.dateIn.month == DateTime.now().month) {
        mlist.add(element);
      }
    }
    return mlist;
  }

  List<ProductModel> get productsToday {
    List<ProductModel> mlist = [];
    for (var element in products) {
      if (element.dateIn.day == DateTime.now().day) {
        mlist.add(element);
      }
    }
    return mlist;
  }

  List<ProductModel> get productsThisWeek {
    List<ProductModel> mlist = [];
    for (var element in products) {
      if (element.dateIn.weekday == DateTime.now().weekday) {
        mlist.add(element);
      }
    }
    return mlist;
  }

  List<ProductModel> get productsThisYear {
    List<ProductModel> mlist = [];
    for (var element in products) {
      if (element.dateIn.year == DateTime.now().year) {
        mlist.add(element);
      }
    }
    return mlist;
  }

  List<ProductModel> productsByDateRange({required MDateRange dateRange}) {
    List<ProductModel> mlist = [];
    for (var element in products) {
      if (element.dateIn.isAfter(dateRange.start) &&
          element.dateIn.isBefore(dateRange.end)) {
        mlist.add(element);
      }
    }
    return mlist;
  }
}
