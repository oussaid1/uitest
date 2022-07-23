part of 'sale.dart';

class FilteredProductSales {
  FilteredSales sales;
  FilteredProductSales({required this.sales});
  get _filteredProductSales => sales.productSales;

  List<DateTime> distinctDates() {
    List<DateTime> dates = [];

    return dates;
  }

  List<DateTime> distinctMonths() {
    List<DateTime> months = [];

    return months;
  }

  List<DateTime> distinctYears() {
    List<DateTime> years = [];

    return years;
  }

  List<SaleModel> get productSalesThisMonth {
    return _filteredProductSales
        .where((SaleModel sale) => sale.dateSold.month == DateTime.now().month)
        .toList();
  }

  List<SaleModel> get seviceSalesToday {
    return _filteredProductSales
        .where((SaleModel sale) => sale.dateSold.day == DateTime.now().day)
        .toList();
  }

  List<SaleModel> get productSalesThisWeek {
    return _filteredProductSales
        .where(
            (SaleModel sale) => sale.dateSold.weekday == DateTime.now().weekday)
        .toList();
  }

  List<SaleModel> get productSalesThisYear {
    return _filteredProductSales
        .where((SaleModel sale) => sale.dateSold.year == DateTime.now().year)
        .toList();
  }

  List<SaleModel> productSalesByDateRange(DateTime start, DateTime end) {
    return _filteredProductSales
        .where((SaleModel sale) =>
            sale.dateSold.isAfter(start) && sale.dateSold.isBefore(end))
        .toList();
  }

// get list of sale by date
  List<SaleModel> productSalesByDate(DateTime date) {
    return _filteredProductSales
        .where((SaleModel sale) => sale.dateSold.ddmmyyyy() == date.ddmmyyyy())
        .toList();
  }
}
