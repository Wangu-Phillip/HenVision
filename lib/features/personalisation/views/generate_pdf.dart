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
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Download PDF Report",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                child: Container(
                  width: screenWidth * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(0, 1),
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // PDF ICON
                      const Icon(
                        Icons.picture_as_pdf,
                        color: Color(0xFF6D62F7),
                        size: 25,
                      ),

                      // REPORT DATE
                      Text(
                        "02/0${index+1}/2024 Report",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),

                      // DOWNLOAD ICON
                      IconButton(
                        onPressed: generateReport,
                        icon: const Icon(
                          Icons.download,
                          size: 25,
                          color: Color(0xFF6D62F7),
                        ),
                      ),

                    ],
                  ),
                ),
              );
            },
        ),
      ),
    );
  }

  void generateReport() async {
    setState(() {
      _isLoading = true;
    });

    // show loading circle
    _showLoadingDialog();

    // after 3 seconds remove loading circle
    Future.delayed(const Duration(seconds: 3), () {
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
