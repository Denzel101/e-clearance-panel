import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:schoolmanagement/repository/over_repository.dart';
import 'package:schoolmanagement/widgets/custom_text_field.dart';
import 'package:schoolmanagement/widgets/submit_button.dart';

import '../../provider/notification_state.dart';
import 'auths/authmodels/sidemenus.dart';
import 'auths/ob/over_model.dart';
import 'auths/overviewcards/data.dart';
import 'auths/overviewcards/style.dart';
import 'customtext.dart';
import 'locator.dart';

class OverScreen extends StatefulWidget {
  static const String id = 'Handing/Taking over';
  const OverScreen({Key? key}) : super(key: key);

  @override
  State<OverScreen> createState() => _OverScreenState();
}

class _OverScreenState extends State<OverScreen> {
  final TextEditingController nameHandOverTextEditingController =
      TextEditingController();
  final TextEditingController nameTakeOverTextEditingController =
      TextEditingController();
  final TextEditingController narrativeHandOverTextEditingController =
      TextEditingController();
  final TextEditingController narrativeTakeOverTextEditingController =
      TextEditingController();
  final TextEditingController acceptingNameTextEditingController =
      TextEditingController();
  final TextEditingController commentTextEditingController =
      TextEditingController();
  final FocusNode nameTakeOverFocusNode = FocusNode();
  final FocusNode nameHandOverFocusNode = FocusNode();
  final FocusNode commentFocusNode = FocusNode();
  final FocusNode narrativeTakeOverFocuNode = FocusNode();
  final FocusNode narrativeHandOverFocuNode = FocusNode();
  final FocusNode acceptingNameFocusNode = FocusNode();
  final SideBarWidget _sideBar = SideBarWidget();
  final _formKey = GlobalKey<FormState>();
  String? selectedItem = 'Handover';
  OverModel? siteSelectedItem;
  String? selectedSite;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameHandOverTextEditingController.dispose();
    nameTakeOverTextEditingController.dispose();
    commentTextEditingController.dispose();
    narrativeHandOverTextEditingController.dispose();
    narrativeTakeOverTextEditingController.dispose();
    acceptingNameTextEditingController.dispose();
    acceptingNameFocusNode.dispose();
    narrativeHandOverFocuNode.dispose();
    narrativeTakeOverFocuNode.dispose();
    nameTakeOverFocusNode.dispose();
    nameHandOverFocusNode.dispose();
    commentFocusNode.dispose();
    super.dispose();
  }

  void removeFocusNodes() {
    nameTakeOverFocusNode.unfocus();
    nameHandOverFocusNode.unfocus();
    narrativeTakeOverFocuNode.unfocus();
    narrativeHandOverFocuNode.unfocus();
    acceptingNameFocusNode.unfocus();
    acceptingNameFocusNode.unfocus();
    commentFocusNode.unfocus();
  }

  void _clearFormField() {
    narrativeTakeOverTextEditingController.clear();
    narrativeHandOverTextEditingController.clear();
    nameHandOverTextEditingController.clear();
    nameTakeOverTextEditingController.clear();
    acceptingNameTextEditingController.clear();
    acceptingNameTextEditingController.clear();
    commentTextEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AdminScaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Visibility(
                child: CustomText(
              text: 'Handover/Takeover',
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
      sideBar: _sideBar.SideBarMenus(context, OverScreen.id),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
        child: Form(
          key: _formKey,
          child: StreamBuilder<List<OverModel>>(
              stream: locator.get<OverRepository>().getOccurenceList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  const Text('loading');
                }
                if (snapshot.hasError) {
                  if (kDebugMode) {
                    print('Ths is error' + snapshot.error.toString());
                  }
                }
                final _overList = snapshot.data ?? [];
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Over Type',
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
                        items: overListItems
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
                    Builder(builder: (context) {
                      if (selectedItem == 'Handover') {
                        return Column(
                          children: [
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
                                value: selectedSite,
                                items: sitesListItems
                                    .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style:
                                              const TextStyle(fontSize: 20.0),
                                        )))
                                    .toList(),
                                onChanged: (String? item) {
                                  setState(() => selectedSite = item);
                                },
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            CustomTextField(
                              onTap: () {},
                              label: 'Name',
                              obscure: false,
                              keyBoard: TextInputType.text,
                              mFocusNode: nameHandOverFocusNode,
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 1,
                              mValidation: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Name is required';
                                } else if (value.trim().length <= 4) {
                                  return 'Name must contain more than \n5 characters';
                                }
                                return null;
                              },
                              textEditingController:
                                  nameHandOverTextEditingController,
                              mOnSaved: (String? value) {
                                nameHandOverTextEditingController.text = value!;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            CustomTextField(
                              onTap: () {},
                              label: 'What am I handing over?',
                              obscure: false,
                              keyBoard: TextInputType.text,
                              mFocusNode: narrativeHandOverFocuNode,
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 3,
                              mValidation: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Narrative is required';
                                } else if (value.trim().length <= 4) {
                                  return 'Narrative must contain more than \n5 characters';
                                }
                                return null;
                              },
                              textEditingController:
                                  narrativeHandOverTextEditingController,
                              mOnSaved: (String? value) {
                                narrativeHandOverTextEditingController.text =
                                    value!;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SubmitButton(
                              label: 'Submit',
                              formKey: _formKey,
                              removeFocusNodes: removeFocusNodes,
                              callBack: () async {
                                await locator
                                    .get<OverRepository>()
                                    .registerDetails(
                                      overType: selectedItem!,
                                      name: nameHandOverTextEditingController
                                          .text,
                                      narrative:
                                          narrativeHandOverTextEditingController
                                              .text,
                                      site: selectedSite!,
                                    );
                                _clearFormField();
                                Provider.of<NotificationState>(context,
                                        listen: false)
                                    .showErrorToast(
                                        'Occurence recorded', false);
                              },
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButtonFormField<OverModel?>(
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
                                  items: [
                                    for (final occurenceDetails in _overList)
                                      if (occurenceDetails.isPending == true)
                                        DropdownMenuItem(
                                          child: Text(
                                            occurenceDetails.site,
                                          ),
                                          value: occurenceDetails,
                                        ),
                                  ],
                                  onChanged: (OverModel? item) {
                                    if (item == null) {
                                      return;
                                    }
                                    setState(() {
                                      siteSelectedItem = item;
                                      nameTakeOverTextEditingController.text =
                                          item.name;
                                      narrativeTakeOverTextEditingController
                                          .text = item.narrative;
                                    });
                                  }),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            CustomTextField(
                              onTap: () {},
                              label: 'Name',
                              readOnly: true,
                              obscure: false,
                              keyBoard: TextInputType.text,
                              mFocusNode: nameTakeOverFocusNode,
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 1,
                              mValidation: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Name is required';
                                } else if (value.trim().length <= 4) {
                                  return 'Name must contain more than \n5 characters';
                                }
                                return null;
                              },
                              textEditingController:
                                  nameTakeOverTextEditingController,
                              mOnSaved: (String? value) {
                                nameTakeOverTextEditingController.text = value!;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            CustomTextField(
                              onTap: () {},
                              label: 'Narrative',
                              obscure: false,
                              readOnly: true,
                              keyBoard: TextInputType.text,
                              mFocusNode: narrativeTakeOverFocuNode,
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 3,
                              mValidation: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Name is required';
                                } else if (value.trim().length <= 4) {
                                  return 'Name must contain more than \n5 characters';
                                }
                                return null;
                              },
                              textEditingController:
                                  narrativeTakeOverTextEditingController,
                              mOnSaved: (String? value) {
                                narrativeTakeOverTextEditingController.text =
                                    value!;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            CustomTextField(
                              onTap: () {},
                              label: 'Who\'s accepting the handover?',
                              obscure: false,
                              keyBoard: TextInputType.text,
                              mFocusNode: acceptingNameFocusNode,
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 1,
                              mValidation: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Name is required';
                                } else if (value.trim().length <= 4) {
                                  return 'Name must contain more than \n5 characters';
                                }
                                return null;
                              },
                              textEditingController:
                                  acceptingNameTextEditingController,
                              mOnSaved: (String? value) {
                                acceptingNameTextEditingController.text =
                                    value!;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            CustomTextField(
                              onTap: () {},
                              label: 'Comment',
                              obscure: false,
                              keyBoard: TextInputType.text,
                              mFocusNode: commentFocusNode,
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 3,
                              mValidation: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Comment is required';
                                } else if (value.trim().length <= 4) {
                                  return 'Comment must contain more than \n5 characters';
                                }
                                return null;
                              },
                              textEditingController:
                                  commentTextEditingController,
                              mOnSaved: (String? value) {
                                commentTextEditingController.text = value!;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SubmitButton(
                              label: 'Submit',
                              formKey: _formKey,
                              removeFocusNodes: removeFocusNodes,
                              callBack: () async {
                                for (final occurenceDetails in _overList) {
                                  await locator
                                      .get<OverRepository>()
                                      .updateDetailsEntry(
                                        id: occurenceDetails.id,
                                        acceptingName:
                                            acceptingNameTextEditingController
                                                .text,
                                        comment:
                                            commentTextEditingController.text,
                                        overType: siteSelectedItem?.overType ==
                                                'Takeover'
                                            ? 'Takeover'
                                            : 'Takeover',
                                      );
                                }
                                _clearFormField();
                                Provider.of<NotificationState>(context,
                                        listen: false)
                                    .showErrorToast(
                                        'Occurence recorded', false);
                              },
                            ),
                          ],
                        );
                      }
                    }),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
