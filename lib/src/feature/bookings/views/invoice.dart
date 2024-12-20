import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class CreateInvoice {
  static Future<String> createInvoicePDF() async {
    final pdf = pw.Document();
    final imageBytes = await rootBundle.load(ImageAssets.appLogo);
    final image = pw.MemoryImage(imageBytes.buffer.asUint8List());
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                color: PdfColors.grey300,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(
                      image,
                      width: 100,
                    ),
                    pw.Text("INVOICE",
                        style: pw.TextStyle(
                            fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Invoice Date: 02.08.2022',
                        style: const pw.TextStyle(color: PdfColors.grey600)),
                    pw.Text('#794653',
                        style: const pw.TextStyle(color: PdfColors.grey600)),
                  ]),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("BILLED BY",
                          style: const pw.TextStyle(color: PdfColors.grey600)),
                      pw.SizedBox(height: 10),
                      pw.Text("BookMyStudio",
                          style: const pw.TextStyle(fontSize: 18)),
                      pw.SizedBox(height: 10),
                      pw.Text(
                          "55 W 39th St, New York,\n NY 10018,\nUnited States",
                          style: const pw.TextStyle(color: PdfColors.grey600)),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("BILLED TO",
                          style: const pw.TextStyle(color: PdfColors.grey600)),
                      pw.SizedBox(height: 10),
                      pw.Text("John Doe",
                          style: const pw.TextStyle(fontSize: 18)),
                      pw.SizedBox(height: 10),
                      pw.Text("6 Kelly Rd,\nCambridge, MA\n02139, EUA",
                          style: const pw.TextStyle(color: PdfColors.grey600)),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("INFO:",
                          style: const pw.TextStyle(color: PdfColors.grey600)),
                      pw.SizedBox(height: 10),
                      pw.Text("Book PAN:\n54654515315313520",
                          style: const pw.TextStyle(color: PdfColors.grey600)),
                      pw.SizedBox(height: 10),
                      pw.Text("Book GST No:\nNIL00 INGB 0000 0000 00",
                          style: const pw.TextStyle(color: PdfColors.grey600)),
                      pw.SizedBox(height: 10),
                      pw.Text("Book CIN No:\n8946546545215",
                          style: const pw.TextStyle(color: PdfColors.grey600)),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                color: PdfColors.grey300,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                        child: pw.Text("QUANTITY",
                            textAlign: pw.TextAlign.center)),
                    pw.Expanded(
                        child:
                            pw.Text("SERVICE", textAlign: pw.TextAlign.center)),
                    pw.Expanded(
                        child: pw.Text("COST", textAlign: pw.TextAlign.center)),
                  ],
                ),
              ),
              pw.Divider(),
              pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                          child: pw.Text("1", textAlign: pw.TextAlign.center)),
                      pw.Expanded(
                          child: pw.Text("WAREHOUSE RENT\nDescription here",
                              textAlign: pw.TextAlign.center)),
                      pw.Expanded(
                          child: pw.Text("\$4000",
                              textAlign: pw.TextAlign.center)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                          child: pw.Text("1", textAlign: pw.TextAlign.center)),
                      pw.Expanded(
                          child: pw.Text("MAINTENANCE\nDescription here",
                              textAlign: pw.TextAlign.center)),
                      pw.Expanded(
                          child: pw.Text("\$2000",
                              textAlign: pw.TextAlign.center)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                          child: pw.Text("1", textAlign: pw.TextAlign.center)),
                      pw.Expanded(
                          child: pw.Text("SECURITY CHARGES\nDescription here",
                              textAlign: pw.TextAlign.center)),
                      pw.Expanded(
                          child: pw.Text("\$1000",
                              textAlign: pw.TextAlign.center)),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text("TOTAL: ",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text("\$7000"),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("Mr. Rajesh Kumar",
                        style: const pw.TextStyle(color: PdfColors.grey800)),
                    pw.Text("Authorized Signatory",
                        style: const pw.TextStyle(color: PdfColors.grey600)),
                    pw.Text("Prepeat Home Services Pvt. Ltd.",
                        style: const pw.TextStyle(color: PdfColors.grey600)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/invoice.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    log(filePath);
    return filePath;
  }
}
