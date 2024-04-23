
import 'package:hen_vision/features/personalisation/models/supplier.dart';
import 'customer.dart';

class Report {
  final ReportInfo info;
  final PoultryCompany companyName;
  final List<ReportItem> items;

  const Report({
    required this.info,
    required this.companyName,
    required this.items,
  });
}

class ReportInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const ReportInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class ReportItem {
  final String category;
  final DateTime date;
  final double amount;

  const ReportItem({
    required this.category,
    required this.date,
    required this.amount,
  });
}