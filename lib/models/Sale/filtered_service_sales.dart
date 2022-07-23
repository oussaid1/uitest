part of 'sale.dart';

class FilteredServiceSales {
  FilteredSales filteredSales;
  FilteredServiceSales({required this.filteredSales});
  get filteredServiceSales => filteredSales.techServiceSales;

  distinctDates() {
    List<DateTime> dates = [];

    return dates;
  }

  distinctMonths() {
    List<DateTime> months = [];

    return months;
  }

  distinctYears() {
    List<DateTime> years = [];
    years.addAll(filteredServiceSales
        .map((SaleModel sale) => sale.dateSold)
        .toset()
        .toList());
    return years;
  }

  List<SaleModel> serviceSalesByDate(DateTime date) {
    return filteredServiceSales
        .where((SaleModel sale) => sale.dateSold.ddmmyyyy() == date.ddmmyyyy())
        .toList();
  }

  List<SaleModel> get serviceSalesThisMonth {
    return filteredServiceSales
        .where((SaleModel sale) => sale.dateSold.month == DateTime.now().month)
        .toList();
  }

  List<SaleModel> get seviceSalesToday {
    return filteredServiceSales
        .where((SaleModel sale) => sale.dateSold.day == DateTime.now().day)
        .toList();
  }

  List<SaleModel> get serviceSalesThisWeek {
    return filteredServiceSales
        .where(
            (SaleModel sale) => sale.dateSold.weekday == DateTime.now().weekday)
        .toList();
  }

  List<SaleModel> get serviceSalesThisYear {
    return filteredServiceSales
        .where((SaleModel sale) => sale.dateSold.year == DateTime.now().year)
        .toList();
  }

  List<SaleModel> serviceSalesByDateRange(DateTime start, DateTime end) {
    return filteredServiceSales
        .where((SaleModel sale) =>
            sale.dateSold.isAfter(start) && sale.dateSold.isBefore(end))
        .toList();
  }
}
