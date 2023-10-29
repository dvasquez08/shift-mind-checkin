import 'package:checkin_q/checkIn.dart';
import 'package:checkin_q/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'checkOut.dart';
import 'package:intl/intl.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late String formattedDate;
  late Ticker _ticker;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(
          'Welcome To CheckinQ',
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.w300, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/clock3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SansText('$formattedDate', 25.0),
            SizedBox(height: 15.0),
            SansText('Welcome to CheckinQ!', 50.0),
            SizedBox(height: 15.0),
            SansText('Select an option below to begin:', 25.0),
            SizedBox(height: 50.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0XFF274c77),
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0XFFa3cef1),
                        blurRadius: 12.0,
                        offset: Offset(4, 4),
                      )
                    ],
                  ),
                  child: MaterialButton(
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => checkIn(),
                        ),
                      );
                    },
                    child: Text(
                      'Check In',
                      style: GoogleFonts.openSans(
                          fontSize: 30.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0XFF274c77),
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0XFFa3cef1),
                        blurRadius: 12.0,
                        offset: Offset(4, 4),
                      )
                    ],
                  ),
                  child: MaterialButton(
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => checkOut(),
                        ),
                      );
                    },
                    child: Text(
                      'Check Out',
                      style: GoogleFonts.openSans(
                          fontSize: 30.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
