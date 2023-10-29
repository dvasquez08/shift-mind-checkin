import 'package:checkin_q/components.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: checkOut()));
}

class checkOut extends StatefulWidget {
  const checkOut({Key? key}) : super(key: key);

  @override
  State<checkOut> createState() => _checkOutState();
}

class _checkOutState extends State<checkOut> {
  String scanResult = '';
  String code = '';
  String checkOut = '';

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Check Out',
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.w300, color: Colors.white),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/clock2.png'),
            fit: BoxFit.cover,
          ),
        ),

        // Check-out section, where staff will scan their QR code to check out.
        //Username and password sign-in haven't been built yet.

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SansText('Shift Clock Out', 50.0),
            SizedBox(height: 15.0),
            SansText('Scan your QR code below to check out and end your shift',
                20.0),
            SansText('or sign-in with your username and password below', 20.0),
            SizedBox(height: 15.0),
            GestureDetector(
              onTap: scanBarcode,
              child: Container(
                height: widthDevice / 17,
                width: heightDevice / 10,
                decoration: BoxDecoration(
                  color: Color(0XFF6096ba),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      offset: Offset(2, 2),
                      blurRadius: 25.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Image.asset('assets/qr.png')],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              scanResult == null ? "Scan a code!" : "Thank you",
              style: TextStyle(fontSize: 25.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future scanBarcode() async {
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6677',
        'cancel',
        false,
        ScanMode.QR,
      );
    } on PlatformException {
      scanResult = 'Failed to get code';
    }

    if (!mounted) return;

    setState(() => this.scanResult = scanResult);

    Map<String, dynamic> dataToSend = {'timestamp': DateTime.now()};

    code = scanResult;

    FirebaseFirestore.instance
        .collection('staff')
        .doc(code)
        .collection('checkOut')
        .add(dataToSend);
  }
}
