part of 'payment.dart';

class FilteredPayments {
  List<PaymentModel> payments;
  FilteredPayments({required this.payments});

  List<String> get distinctClients {
    List<String> clients = [];
    // for (var item in payments) {
    //   clients.add(item.!);
    // }
    return clients;
  }

  List<PaymentModel> paymentsByClient(List<PaymentModel> payments) {
    List<PaymentModel> payments = [];
    for (var item in distinctClients) {
      payments = payments.where((element) => element.clientId == item).toList();
    }
    return payments;
  }

  List<PaymentModel> paymentsByDate(DateTime date) {
    List<PaymentModel> payments = [];
    for (var item in payments) {
      if (item.date.day == date.day &&
          item.date.month == date.month &&
          item.date.year == date.year) {
        payments.add(item);
      }
    }
    return payments;
  }

  List<DateTime> get distinctDates {
    List<DateTime> list = [];
    for (var element in payments) {
      list.add(element.date);
    }
    return list.toSet().toList();
  }

  List<PaymentModel> paymentsToday() {
    List<PaymentModel> payments = [];
    for (var item in payments) {
      if (item.date.day == DateTime.now().day &&
          item.date.month == DateTime.now().month &&
          item.date.year == DateTime.now().year) {
        payments.add(item);
      }
    }
    return payments;
  }

  List<PaymentModel> paymentsThisMonth() {
    List<PaymentModel> payments = [];
    for (var item in payments) {
      if (item.date.month == DateTime.now().month &&
          item.date.year == DateTime.now().year) {
        payments.add(item);
      }
    }
    return payments;
  }

  List<PaymentModel> paymentsThisYear() {
    List<PaymentModel> payments = [];
    for (var item in payments) {
      if (item.date.year == DateTime.now().year) {
        payments.add(item);
      }
    }
    return payments;
  }

  List<PaymentModel> paymentsThisWeek() {
    List<PaymentModel> payments = [];
    for (var item in payments) {
      if (item.date.weekday == DateTime.now().weekday &&
          item.date.year == DateTime.now().year) {
        payments.add(item);
      }
    }
    return payments;
  }

  List<PaymentModel> paymentsByDateRange(DateTime start, DateTime end) {
    List<PaymentModel> payments = [];
    for (var item in payments) {
      if (item.date.isAfter(start) && item.date.isBefore(end)) {
        payments.add(item);
      }
    }
    return payments;
  }
}
