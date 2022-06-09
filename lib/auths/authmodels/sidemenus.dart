import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolmanagement/auths/homepage.dart';
import 'package:schoolmanagement/auths/students.dart';
import 'package:schoolmanagement/ob.dart';
import 'package:schoolmanagement/over.dart';
import 'package:schoolmanagement/overhistory.dart';

import '../stakeholders.dart';

class SideBarWidget {
  SideBarMenus(context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: CupertinoColors.systemBlue,
      activeIconColor: Colors.white,
      iconColor: CupertinoColors.systemBlue,
      textStyle: GoogleFonts.poppins(
        color: Colors.grey[700],
        fontSize: 13,
      ),
      activeTextStyle: const TextStyle(
        color: Colors.white,
      ),
      // backgroundColor: Colors.black54,
      items: [
        const AdminMenuItem(
          title: 'Dashboard',
          route: HomePage.id,
          icon: Icons.dashboard,
        ),
        AdminMenuItem(
          title: 'Incidents',
          route: StakeHolders.tag,
          icon: Icons.report,
        ),
        const AdminMenuItem(
          title: 'OB',
          route: OB.id,
          icon: Icons.book_outlined,
        ),
        const AdminMenuItem(
          title: 'Handing/Taking over',
          route: Over.id,
          icon: Icons.handshake_outlined,
        ),
        const AdminMenuItem(
          title: 'Handing/Taking over history',
          route: OverHistory.id,
          icon: Icons.book_online,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        Navigator.of(context).pushNamed(item.route!);
      },

      footer: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black26,
        child: Center(
          child: Text(
            '@GuardSuites',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
