import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:schoolmanagement/auths/authmodels/sidemenus.dart';
import 'package:schoolmanagement/auths/ob/table_model.dart';
import 'package:schoolmanagement/auths/overviewcards/services.dart';
import 'package:schoolmanagement/auths/overviewcards/style.dart';
import 'package:schoolmanagement/customtext.dart';

class Students extends StatefulWidget {
  static const String id = 'ob';
  const Students({Key? key}) : super(key: key);

  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    FirebaseServices _services = FirebaseServices();
    bool cleared = false;

    var data;
    return AdminScaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Visibility(
                  child: CustomText(
                text: 'e-clearance',
                color: lightgrey,
                size: 20,
                fontWeight: FontWeight.bold,
              )),
              Expanded(
                child: Container(),
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                color: dark.withOpacity(.7),
                onPressed: () {},
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      color: dark.withOpacity(.7),
                    ),
                  ),
                  Positioned(
                      top: 7,
                      right: 7,
                      child: Container(
                          width: 12,
                          height: 12,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: light, width: 2))))
                ],
              ),
              Container(
                width: 1,
                height: 22,
                color: lightgrey,
              ),
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: light,
                      child: Icon(
                        Icons.person_outline,
                        color: dark,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: dark,
          ),
          backgroundColor: light,
          // iconTheme: IconThemeData(
          //   color: Colors.white,
          // ),
          // title: Text(
          //   'Gobike dashboard'.toUpperCase(),
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontWeight: FontWeight.w900,
          //     fontSize: 19,
          //   ),
          // ),
        ),
        sideBar: _sideBar.SideBarMenus(context, Students.id),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('incidents').snapshots(),
          builder: (context, snapshot) {
            data = snapshot.data;
            if (snapshot.hasError) {
              return const Text('Something Went Wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    showBottomBorder: true,
                    dataRowHeight: 60,
                    headingRowColor: MaterialStateProperty.all(
                      Colors.grey,
                    ),
                    border: TableBorder.all(
                      width: 5.0,
                      color: Colors.grey,
                    ),
                    columns: const [
                      DataColumn(
                        label: Text('Incident Type'),
                      ),
                      DataColumn(
                        label: Text('Reported by'),
                      ),
                      DataColumn(
                        label: Text('Department'),
                      ),
                      DataColumn(
                        label: Text('Escalate to'),
                      ),
                      DataColumn(
                        label: Text('Threat level'),
                      ),
                      DataColumn(
                        label: Text('Sites'),
                      ),
                      DataColumn(
                        label: Text('Brief Statement'),
                      ),
                      DataColumn(
                        label: Text('Resolution'),
                      ),
                    ],
                    rows: _buildList(context, snapshot.data!.docs)));
          },
        ));
  }

  List<DataRow> _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    final occurence = TableModel.fromSnapshot(data);

    return DataRow(cells: [
      DataCell(Text(occurence.incidentType)),
      DataCell(Text(occurence.reportBy)),
      DataCell(Text(occurence.department)),
      DataCell(Text(occurence.escalateTo)),
      DataCell(Text(occurence.threatLevel)),
      DataCell(Text(occurence.site)),
      DataCell(Text(occurence.incidentBrief)),
      DataCell(Text(occurence.resolution)),
    ]);
  }
}
