part of 'sale.dart';

class FilteredSales {
  List<SaleModel> sales;
  DateFilter filterType;
  MDateRange? selectedDateRange;

  FilteredSales({
    required this.sales,
    this.filterType = DateFilter.all,
    this.selectedDateRange,
  });

  /// get filtered sales
  /// @returns List<SaleModel>

  List<SaleModel> get filteredSalesByFilterType {
    if (filterType == DateFilter.all) {
      return sales;
    } else if (filterType == DateFilter.month) {
      return sales
          .where((sale) => sale.dateSold.month == DateTime.now().month)
          .toList();
    } else if (filterType == DateFilter.custom) {
      return sales
          .where((sale) =>
              sale.dateSold.isAfter(selectedDateRange!.start) &&
              sale.dateSold.isBefore(selectedDateRange!.end))
          .toList();
    } else {
      return sales;
    }
  }

  List<SaleModel> salesByType(SaleType saleType) {
    switch (saleType) {
      case SaleType.product:
        return productSales;
      case SaleType.service:
        return techServiceSales;
      case SaleType.all:
        return sales;
      default:
        sales;
    }

    return sales;
  }

// get list of sales by date
  List<SaleModel> salesByDate(DateTime date) {
    return sales
        .where((sale) => sale.dateSold.ddmmyyyy() == date.ddmmyyyy())
        .toList();
  }

  List<SaleModel> get productSales {
    List<SaleModel> mlist = [];
    mlist = sales.where((element) => element.type == SaleType.product).toList();
    return mlist;
  }

  List<SaleModel> get techServiceSales {
    List<SaleModel> mlist = [];
    mlist = sales.where((element) => element.type == SaleType.service).toList();
    return mlist;
  }

/////////////////////////////////////////////////////////////////////////
  List<String> get distinctCilentNames {
    List<String> mlist = [];
    for (var element in sales) {
      mlist.add(element.shopClientId);
    }
    return mlist.toSet().toList();
  }

  /// distinct categories
  List<String> get distinctCategories {
    List<String> mlist = [];
    for (var element in sales) {
      mlist.add(element.category!);
    }
    return mlist.toSet().toList();
  }

  List<String> distinctddmmyy(SaleType saleType) {
    List<String> mlist = [];
    for (var element in salesByType(saleType)) {
      mlist.add(element.dateSold.ddmmyyyy());
    }
    return mlist.toSet().toList();
  }

  List<String> distinctmmyy(SaleType saleType) {
    List<String> mlist = [];
    for (var element in salesByType(saleType)) {
      mlist.add(element.dateSold.ddmmyyyy());
    }
    return mlist.toSet().toList();
  }

  List<String> distinctyy(SaleType saleType) {
    List<String> mlist = [];
    for (var element in salesByType(saleType)) {
      mlist.add(element.dateSold.ddmmyyyy());
    }
    return mlist.toSet().toList();
  }

/////////////////////////////////////////////////////////////////////
  int get salesCount {
    int mcount = 0;
    for (var element in sales) {
      mcount += (element.count);
    }
    return mcount;
  }

  List<SaleModel> get salesThisMonth {
    return sales
        .where((element) => element.dateSold.month == DateTime.now().month)
        .toList();
  }

  List<SaleModel> get salesThisYear {
    return sales
        .where((element) => element.dateSold.year == DateTime.now().year)
        .toList();
  }

  List<SaleModel> get salesThisWeek {
    return sales
        .where((element) => element.dateSold.weekday == DateTime.now().weekday)
        .toList();
  }

  List<SaleModel> get salesThisDay {
    return sales
        .where((element) => element.dateSold.day == DateTime.now().day)
        .toList();
  }

  List<SaleModel> salesByDateRange(DateTime startDate, DateTime endDate) {
    return sales
        .where((element) =>
            element.dateSold.isAfter(startDate) &&
            element.dateSold.isBefore(endDate))
        .toList();
  }
  ///////////////////////////////////////////////////////////

  List<SaleModel> soldProductsByDateTime(SaleType saleType, DateTime dateTime) {
    return salesByType(saleType)
        .where(
            (element) => element.dateSold.formatted() == dateTime.formatted())
        .toList();
  }

  List<SaleModel> soldProductsByDay(SaleType saleType, String dateTime) {
    return salesByType(saleType)
        .where((element) => element.dateSold.ddmmyyyy() == dateTime)
        .toList();
  }

  List<SaleModel> soldProductsByMonth(SaleType saleType, String dateTime) {
    return salesByType(saleType)
        .where((element) => element.dateSold.ddmmyyyy() == dateTime)
        .toList();
  }

  List<SaleModel> soldProductsByYear(SaleType saleType, String dateTime) {
    return salesByType(saleType)
        .where((element) => element.dateSold.ddmmyyyy() == dateTime)
        .toList();
  }
}
