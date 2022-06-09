import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auths/authmodels/sidemenus.dart';
import 'auths/overviewcards/style.dart';
import 'customtext.dart';

class OverHistory extends StatefulWidget {
  static const String id = 'Handing/Taking over logs';
  const OverHistory({Key? key}) : super(key: key);
  @override
  _OverHistoryState createState() => _OverHistoryState();
}

class _OverHistoryState extends State<OverHistory> {
  final SideBarWidget _sideBar = SideBarWidget();
  late List<DatatableHeader> _headers;
  List<int> _perPages = [10, 20, 50, 100];
  int _total = 100;
  int? _currentPerPage = 10;
  List<bool>? _expanded;
  String? _searchKey = "id";

  int _currentPage = 1;
  bool _isSearch = false;
  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];

  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;

  Future<List<Map<String, dynamic>>> getData() async{
    List<Map<String, dynamic>> _data = [];
    final  _collectionRef = FirebaseFirestore.instance;
    await _collectionRef.collection("overs").get().then((event) {
      for (var doc in event.docs) {
        _data.add(doc.data());
      }
    });
    return _data;
  }

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage!, (index) => false);
    Future<List<Map<String, dynamic>>> _futureList = getData();
    List<Map<String, dynamic>> list = await _futureList;
    print(list);
    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _sourceOriginal.clear();
      _sourceOriginal.addAll(list);
      _sourceFiltered = _sourceOriginal;
      _total = _sourceFiltered.length;
      _source = _sourceFiltered.getRange(0, _currentPerPage!).toList();
      setState(() => _isLoading = false);
    });
  }

  _resetData({start: 0}) async {
    setState(() => _isLoading = true);
    var _expandedLen =
    _total - start < _currentPerPage! ? _total - start : _currentPerPage;
    Future.delayed(Duration(seconds: 0)).then((value) {
      _expanded = List.generate(_expandedLen as int, (index) => false);
      _source.clear();
      _source = _sourceFiltered.getRange(start, start + _expandedLen).toList();
      setState(() => _isLoading = false);
    });
  }

  _filterData(value) {
    setState(() => _isLoading = true);

    try {
      if (value == "" || value == null) {
        _sourceFiltered = _sourceOriginal;
      } else {
        _sourceFiltered = _sourceOriginal
            .where((data) => data[_searchKey!]
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase()))
            .toList();
      }

      _total = _sourceFiltered.length;
      var _rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
      _expanded = List.generate(_rangeTop, (index) => false);
      _source = _sourceFiltered.getRange(0, _rangeTop).toList();
    } catch (e) {
      print(e);
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    /// set headers
    _headers = [
      DatatableHeader(
          text: "Site",
          value: "site",
          show: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Handing/Taking Over",
          value: "overType",
          show: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Handed Over By",
          value: "name",
          show: true,
          sortable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Narrative",
          flex: 3,
          value: "narrative",
          show: true,
          sortable: false,
          editable: false,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Taken Over By",
          value: "acceptingName",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Comment",
          value: "comment",
          flex: 2,
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
    ];
    _initializeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Visibility(
                child: CustomText(
                  text: 'GUARD SUITES PLUS',
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
            Container(
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
      sideBar: _sideBar.SideBarMenus(context, OverHistory.id),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(
                    maxHeight: 700,
                  ),
                  child: Card(
                    elevation: 3,
                    shadowColor: Colors.black,
                    clipBehavior: Clip.none,
                    child: ResponsiveDatatable(
                      title: TextButton.icon(
                        onPressed: () => {},
                        icon: Icon(Icons.add),
                        label: Text("new item"),
                      ),
                      reponseScreenSizes: [ScreenSize.xs],
                      actions: [
                        if (_isSearch)
                          Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Enter search term based on ' +
                                        _searchKey!
                                            .replaceAll(new RegExp('[\\W_]+'), ' ')
                                            .toUpperCase(),
                                    prefixIcon: IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          setState(() {
                                            _isSearch = false;
                                          });
                                          _initializeData();
                                        }),
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.search), onPressed: () {})),
                                onSubmitted: (value) {
                                  _filterData(value);
                                },
                              )),
                        if (!_isSearch)
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  _isSearch = true;
                                });
                              })
                      ],
                      headers: _headers,
                      source: _source,
                      selecteds: _selecteds,
                      showSelect: _showSelect,
                      autoHeight: false,
                      onChangedRow: (value, header) {
                        /// print(value);
                        /// print(header);
                      },
                      onSubmittedRow: (value, header) {
                        /// print(value);
                        /// print(header);
                      },
                      onTabRow: (data) {
                        print(data);
                      },
                      onSort: (value) {
                        setState(() => _isLoading = true);

                        setState(() {
                          _sortColumn = value;
                          _sortAscending = !_sortAscending;
                          if (_sortAscending) {
                            _sourceFiltered.sort((a, b) =>
                                b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                          } else {
                            _sourceFiltered.sort((a, b) =>
                                a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                          }
                          var _rangeTop = _currentPerPage! < _sourceFiltered.length
                              ? _currentPerPage!
                              : _sourceFiltered.length;
                          _source = _sourceFiltered.getRange(0, _rangeTop).toList();
                          _searchKey = value;

                          _isLoading = false;
                        });
                      },
                      expanded: _expanded,
                      sortAscending: _sortAscending,
                      sortColumn: _sortColumn,
                      isLoading: _isLoading,
                      onSelect: (value, item) {
                        print("$value  $item ");
                        if (value!) {
                          setState(() => _selecteds.add(item));
                        } else {
                          setState(
                                  () => _selecteds.removeAt(_selecteds.indexOf(item)));
                        }
                      },
                      onSelectAll: (value) {
                        if (value!) {
                          setState(() => _selecteds =
                              _source.map((entry) => entry).toList().cast());
                        } else {
                          setState(() => _selecteds.clear());
                        }
                      },
                      footers: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Rows per page:"),
                        ),
                        if (_perPages.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton<int>(
                              value: _currentPerPage,
                              items: _perPages
                                  .map((e) => DropdownMenuItem<int>(
                                child: Text("$e"),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (dynamic value) {
                                setState(() {
                                  _currentPerPage = value;
                                  _currentPage = 1;
                                  _resetData();
                                });
                              },
                              isExpanded: false,
                            ),
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child:
                          Text("$_currentPage - $_currentPerPage of $_total"),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          onPressed: _currentPage == 1
                              ? null
                              : () {
                            var _nextSet = _currentPage - _currentPerPage!;
                            setState(() {
                              _currentPage = _nextSet > 1 ? _nextSet : 1;
                              _resetData(start: _currentPage - 1);
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: _currentPage + _currentPerPage! - 1 > _total
                              ? null
                              : () {
                            var _nextSet = _currentPage + _currentPerPage!;

                            setState(() {
                              _currentPage = _nextSet < _total
                                  ? _nextSet
                                  : _total - _currentPerPage!;
                              _resetData(start: _nextSet - 1);
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ])),
    );
  }
}

class _DropDownContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  const _DropDownContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = data.entries.map<Widget>((entry) {
      Widget w = Row(
        children: [
          Text(entry.key.toString()),
          Spacer(),
          Text(entry.value.toString()),
        ],
      );
      return w;
    }).toList();

    return Container(
      height: 200,
      child: Column(
        /// children: [
        ///   Expanded(
        ///       child: Container(
        ///     color: Colors.red,
        ///     height: 50,
        ///   )),

        /// ],
        children: _children,
      ),
    );
  }
}
