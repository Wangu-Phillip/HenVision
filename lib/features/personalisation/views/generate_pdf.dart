import 'package:flutter/material.dart';

import '../../../api/pdf_api.dart';
import '../../../api/pdf_invoice_api.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/title.dart';
import '../models/customer.dart';
import '../models/invoice.dart';
import '../models/supplier.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      title: const Text(
          "Generate PDF",
      ),
      centerTitle: true,
    ),
    body: Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Icon(icon)
            const TitleWidget(
              icon: Icons.picture_as_pdf,
              text: 'Generate Report',

            ),
            const SizedBox(height: 48),

            GestureDetector(
              onTap: () async {
                final date = DateTime.now();
                final dueDate = date.add(const Duration(days: 7));

                final invoice = Invoice(
                  supplier: const Supplier(
                    name: 'Sarah Field',
                    address: 'Sarah Street 9, Beijing, China',
                    paymentInfo: 'https://paypal.me/sarahfieldzz',
                  ),
                  customer: const Customer(
                    name: 'Apple Inc.',
                    address: 'Apple Street, Cupertino, CA 95014',
                  ),
                  info: InvoiceInfo(
                    date: date,
                    dueDate: dueDate,
                    description: 'My description...',
                    number: '${DateTime.now().year}-9999',
                  ),
                  items: [
                    InvoiceItem(
                      description: 'Coffee',
                      date: DateTime.now(),
                      quantity: 3,
                      vat: 0.19,
                      unitPrice: 5.99,
                    ),
                    InvoiceItem(
                      description: 'Water',
                      date: DateTime.now(),
                      quantity: 8,
                      vat: 0.19,
                      unitPrice: 0.99,
                    ),
                    InvoiceItem(
                      description: 'Orange',
                      date: DateTime.now(),
                      quantity: 3,
                      vat: 0.19,
                      unitPrice: 2.99,
                    ),
                    InvoiceItem(
                      description: 'Apple',
                      date: DateTime.now(),
                      quantity: 8,
                      vat: 0.19,
                      unitPrice: 3.99,
                    ),
                    InvoiceItem(
                      description: 'Mango',
                      date: DateTime.now(),
                      quantity: 1,
                      vat: 0.19,
                      unitPrice: 1.59,
                    ),
                    InvoiceItem(
                      description: 'Blue Berries',
                      date: DateTime.now(),
                      quantity: 5,
                      vat: 0.19,
                      unitPrice: 0.99,
                    ),
                    InvoiceItem(
                      description: 'Lemon',
                      date: DateTime.now(),
                      quantity: 4,
                      vat: 0.19,
                      unitPrice: 1.29,
                    ),
                  ],
                );

                final pdfFile = await PdfInvoiceApi.generate(invoice);

                PdfApi.openFile(pdfFile);
              },

              child: Container(
                width: 250,
                height: 50,
                alignment: Alignment.center,
                color: Colors.white,

                child: Text(
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
}