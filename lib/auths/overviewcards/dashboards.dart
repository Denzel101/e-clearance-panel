import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:schoolmanagement/auths/ob/ob_model.dart';
import 'package:schoolmanagement/auths/overviewcards/infocard.dart';
import 'package:schoolmanagement/auths/overviewcards/services.dart';
import 'package:schoolmanagement/locator.dart';

import '../../repository/cloud_repository.dart';

class OverviewCards extends StatefulWidget {
  const OverviewCards({Key? key}) : super(key: key);

  @override
  State<OverviewCards> createState() => _OverviewCardsState();
}

class _OverviewCardsState extends State<OverviewCards> {
  String? dataLength;
  String? bursary;
  String? incidents;
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 28.0, left: 18.0, right: 18.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overview",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        StreamBuilder(
                            stream: _services.incidents
                                .snapshots()
                                .map((event) {
                              incidents = event.docs.length.toString();
                            }),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return InfoCard(
                                title: 'Incidents Reported',
                                value: incidents,
                                bezierCOlor: Colors.green,
                                onTap: () {},
                                topColor: Colors.greenAccent,
                              );
                            }),
                        SizedBox(
                          width: _width / 64,
                        ),
                        StreamBuilder(
                            stream: _services.bursary
                                .where("stackholder", isEqualTo: "Bursary")
                                .snapshots()
                                .map((event) {
                              bursary = event.docs.length.toString();
                            }),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return InfoCard(
                                title: 'Supervisors Registered',
                                value: "1",
                                bezierCOlor: Colors.green,
                                onTap: () {},
                                topColor: Colors.greenAccent,
                              );
                            }),
                        SizedBox(
                          width: _width / 64,
                        ),
                        StreamBuilder(
                            stream: _services.bursary
                                .where("stackholder", isEqualTo: "Registry")
                                .snapshots()
                                .map((event) {
                              dataLength = event.docs.length.toString();
                            }),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return InfoCard(
                                title: 'Operations Managers Registered',
                                value: "1",
                                bezierCOlor: Colors.orange,
                                onTap: () {},
                                topColor: Colors.deepOrangeAccent,
                              );
                            }),
                        // St
                        SizedBox(
                          width: _width / 64,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      //   SizedBox(
      //     height: MediaQuery.of(context).size.height / 15,
      //   ),
      //   Card(
      //     elevation: 5,
      //     color: Colors.white,
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 28.0, left: 18.0, right: 18.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             "Students",
      //             style: GoogleFonts.poppins(
      //               fontSize: 25,
      //               fontWeight: FontWeight.w600,
      //               color: Colors.black,
      //             ),
      //           ),
      //           Row(
      //             children: [
      //               Container(
      //                   height: 15,
      //                   width: 15,
      //                   decoration: BoxDecoration(
      //                     color: Colors.cyanAccent[200]!,
      //                     shape: BoxShape.circle,
      //                   )),
      //               const SizedBox(
      //                 width: 10,
      //               ),
      //               const Text(
      //                 "Cleared",
      //               ),
      //             ],
      //           ),
      //           const SizedBox(height: 10),
      //           Row(
      //             children: [
      //               Container(
      //                   height: 15,
      //                   width: 15,
      //                   decoration: const BoxDecoration(
      //                     color: Colors.cyan,
      //                     shape: BoxShape.circle,
      //                   )),
      //               const SizedBox(
      //                 width: 10,
      //               ),
      //               const Text(
      //                 "Blocked",
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: MediaQuery.of(context).size.height / 30,
      //           ),
      //           Row(
      //             children: [
      //               SizedBox(
      //                 width: _width / 64,
      //               ),
      //               CircularPercentIndicator(
      //                 radius: 110.0,
      //                 animation: true,
      //                 animationDuration: 1200,
      //                 lineWidth: 10.0,
      //                 percent: 0.4,
      //                 center: Text(
      //                   "40 hours",
      //                   style: GoogleFonts.poppins(
      //                       fontWeight: FontWeight.bold, fontSize: 14.0),
      //                 ),
      //                 circularStrokeCap: CircularStrokeCap.round,
      //                 backgroundColor: Colors.cyanAccent[200]!,
      //                 progressColor: Colors.cyan,
      //               ),
      //               SizedBox(
      //                 width: _width / 64,
      //               ),
      //               CircularPercentIndicator(
      //                 radius: 110.0,
      //                 animation: true,
      //                 animationDuration: 1200,
      //                 lineWidth: 10.0,
      //                 percent: 0.4,
      //                 center: Text(
      //                   "40 hours",
      //                   style: GoogleFonts.poppins(
      //                       fontWeight: FontWeight.bold, fontSize: 14.0),
      //                 ),
      //                 circularStrokeCap: CircularStrokeCap.round,
      //                 backgroundColor: Colors.cyanAccent[200]!,
      //                 progressColor: Colors.cyan,
      //               ),
      //               SizedBox(
      //                 width: _width / 64,
      //               ),
      //               CircularPercentIndicator(
      //                 radius: 110.0,
      //                 animation: true,
      //                 animationDuration: 1200,
      //                 lineWidth: 10.0,
      //                 percent: 0.4,
      //                 center: Text(
      //                   "40 hours",
      //                   style: GoogleFonts.poppins(
      //                       fontWeight: FontWeight.bold, fontSize: 14.0),
      //                 ),
      //                 circularStrokeCap: CircularStrokeCap.round,
      //                 backgroundColor: Colors.cyanAccent[200]!,
      //                 progressColor: Colors.cyan,
      //               ),
      //               SizedBox(
      //                 width: _width / 64,
      //               ),
      //               CircularPercentIndicator(
      //                 radius: 110.0,
      //                 animation: true,
      //                 animationDuration: 1200,
      //                 lineWidth: 10.0,
      //                 percent: 0.4,
      //                 center: Text(
      //                   "40 hours",
      //                   style: GoogleFonts.poppins(
      //                       fontWeight: FontWeight.bold, fontSize: 14.0),
      //                 ),
      //                 circularStrokeCap: CircularStrokeCap.round,
      //                 backgroundColor: Colors.cyanAccent[200]!,
      //                 progressColor: Colors.cyan,
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   )
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
