import 'package:flutter/material.dart';

import '../../../api/pdf_api.dart';
import '../../../api/pdf_invoice_api.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/title.dart';
import '../models/customer.dart';
import '../models/invoice.dart';
import '../models/supplier.dart';

// FROM GITHUB
class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {

  // loading checker
  bool _isLoading = false;

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: const Text(
          "Generate PDF Report",
      ),
      centerTitle: true,
    ),
    body: Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const Icon(
              Icons.picture_as_pdf,
              color: Color(0xFF6D62F7),
              size: 50,
            ),

            const Text(
              "Generate PDF Report",
              style: TextStyle(
                color: Color(0xFF6D62F7),
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 60),

            GestureDetector(
              onTap: generateReport,

              child: Container(
                width: 250,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF6D62F7),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(0, 4),
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: const Text(
                  'Download Report',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  void generateReport() async {

    setState(() {
      _isLoading = true;
    });

    // show loading circle
    _showLoadingDialog();

    // after 3 seconds remove loading circle
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
      // remove loading circle
      _hideLoadingDialog();
    });
                final date = DateTime.now();
                final dueDate = date.add(const Duration(days: 7));

                final report = Report(
                  companyName: const PoultryCompany(
                    name: 'XYZ Company',
                    address: 'Private Bag 001, Gantsi, Botswana',
                    paymentInfo: 'https://paypal.me/',
                  ),
                  info: ReportInfo(
                    date: date,
                    dueDate: dueDate,
                    description: 'My description...',
                    number: '${DateTime.now().year}-0001',
                  ),
                  items: [
                    ReportItem(
                      category: 'Meat Sales',
                      date: DateTime.now(),
                      amount: 7000.45,
                    ),
                    ReportItem(
                      category: 'Egg Sales',
                      date: DateTime.now(),
                      amount: 6845.12,
                    ),
                    ReportItem(
                      category: 'Feather Sales',
                      date: DateTime.now(),
                      amount: 9865.07,
                    ),
                    ReportItem(
                      category: 'Fertilizer Sales',
                      date: DateTime.now(),
                      amount: 6455.15,
                    ),
                    ReportItem(
                      category: 'Chicken Sales',
                      date: DateTime.now(),
                      amount: 9956.12,
                    ),
                  ],
                );

                final pdfFile = await PdfInvoiceApi.generate(report);

                PdfApi.openFile(pdfFile);
              }
}