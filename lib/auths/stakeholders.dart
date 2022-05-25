import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:schoolmanagement/auths/authmodels/sidemenus.dart';
import 'package:schoolmanagement/auths/overviewcards/style.dart';
import 'package:schoolmanagement/customtext.dart';

import '../locator.dart';
import '../provider/notification_state.dart';
import '../repository/cloud_repository.dart';
import '../repository/storage_repository.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/submit_button.dart';
import 'overviewcards/data.dart';

class StakeHolders extends StatefulWidget {
  static String tag = 'incidents';
  const StakeHolders({Key? key}) : super(key: key);

  @override
  _StakeHoldersState createState() => _StakeHoldersState();
}

class _StakeHoldersState extends State<StakeHolders> {
  final _formKey = GlobalKey<FormState>();
  final SideBarWidget _sideBar = SideBarWidget();
  File? file;
  String? selectedItem = 'High';
  String? escalatedSelectedItem = 'Head of Operations';
  String? siteSelectedItem = 'Delta Plains';
  String? departmentSelectedItem = 'SECURITY';
  String? incidentSelectedItem = 'Crime';

  late TextEditingController reportedByTextEditingController,
      resolutionTextEditingController,
      incidentBriefTextEditingController;

  late FocusNode alarmTypeFocusNode,
      resolutionFocusNode,
      reportByFocusNode,
      incidentFocusNode;

  @override
  void initState() {
    reportedByTextEditingController = TextEditingController();
    resolutionTextEditingController = TextEditingController();
    incidentBriefTextEditingController = TextEditingController();

    resolutionFocusNode = FocusNode();
    alarmTypeFocusNode = FocusNode();
    reportByFocusNode = FocusNode();
    incidentFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    reportedByTextEditingController.dispose();
    resolutionTextEditingController.dispose();
    incidentBriefTextEditingController.dispose();

    reportByFocusNode.dispose();
    resolutionFocusNode.dispose();
    incidentFocusNode.dispose();

    super.dispose();
  }

  void _removeFocusNodes() {
    // remove focus

    reportByFocusNode.unfocus();
    incidentFocusNode.unfocus();
  }

  void _clearFormField() {
    reportedByTextEditingController.clear();
    incidentBriefTextEditingController.clear();
  }

  //upload files to database
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    StorageRepository.uploadFile(destination: destination, file: file!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final fileName = file != null ? basename(file!.path) : 'No file selected';
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
      sideBar: _sideBar.SideBarMenus(context, StakeHolders.tag),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Incident Type',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  value: incidentSelectedItem,
                  items: incidentListItems
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 20.0),
                          )))
                      .toList(),
                  onChanged: (String? item) {
                    setState(() => incidentSelectedItem = item);
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextField(
                onTap: () {},
                label: 'Reported by',
                obscure: false,
                keyBoard: TextInputType.text,
                mFocusNode: reportByFocusNode,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 1,
                mValidation: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Reported by is required';
                  } else if (value.trim().length <= 4) {
                    return 'Reported by must contain more than \n5 characters';
                  }
                  return null;
                },
                textEditingController: reportedByTextEditingController,
                mOnSaved: (String? value) {
                  reportedByTextEditingController.text = value!;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Department',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  value: departmentSelectedItem,
                  items: departmentListItems
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 20.0),
                          )))
                      .toList(),
                  onChanged: (String? item) {
                    setState(() => departmentSelectedItem = item);
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Escalate to',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  value: escalatedSelectedItem,
                  items: escalateToItems
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 20.0),
                          )))
                      .toList(),
                  onChanged: (String? item) {
                    setState(() => escalatedSelectedItem = item);
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Threat level',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  value: selectedItem,
                  items: threatLevelItems
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 20.0),
                          )))
                      .toList(),
                  onChanged: (String? item) {
                    setState(() => selectedItem = item);
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Sites',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  value: siteSelectedItem,
                  items: sitesListItems
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 20.0),
                          )))
                      .toList(),
                  onChanged: (String? item) {
                    setState(() => siteSelectedItem = item);
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextField(
                onTap: () {},
                label: 'Brief Statement',
                obscure: false,
                keyBoard: TextInputType.text,
                mFocusNode: incidentFocusNode,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 6,
                mValidation: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Incident brief is required';
                  } else if (value.trim().length <= 4) {
                    return 'Incident brief must contain more than \n5 characters';
                  }
                  return null;
                },
                textEditingController: incidentBriefTextEditingController,
                mOnSaved: (String? value) {
                  incidentBriefTextEditingController.text = value!;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextField(
                onTap: () {},
                label: 'Resolution',
                obscure: false,
                keyBoard: TextInputType.text,
                mFocusNode: resolutionFocusNode,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                mValidation: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Resolution is required';
                  } else if (value.trim().length <= 4) {
                    return 'Incident brief must contain more than \n5 characters';
                  }
                  return null;
                },
                textEditingController: resolutionTextEditingController,
                mOnSaved: (String? value) {
                  resolutionTextEditingController.text = value!;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ButtonWidget(
                  onPressed: () {
                    selectFile();
                  },
                  buttonName: 'Select File'),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                fileName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SubmitButton(
                  label: 'Submit',
                  formKey: _formKey,
                  removeFocusNodes: _removeFocusNodes,
                  callBack: () async {
                    await locator.get<CloudRepository>().registerDetails(
                          dateTime: DateTime.now(),
                          incidentType: incidentSelectedItem!,
                          reportedBy: reportedByTextEditingController.text,
                          incidentBrief:
                              incidentBriefTextEditingController.text,
                          department: departmentSelectedItem!,
                          escalatedTo: escalatedSelectedItem!,
                          threatLevel: selectedItem!,
                          site: siteSelectedItem!,
                          resolution: resolutionTextEditingController.text,
                        );
                    await uploadFile();
                    _clearFormField();
                    Provider.of<NotificationState>(context, listen: false)
                        .showErrorToast('Occurence recorded', false);
                  }),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
