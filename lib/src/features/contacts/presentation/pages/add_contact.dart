import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/src/core/button.dart';
import 'package:flutter_base_project/src/core/colors.dart';
import 'package:flutter_base_project/src/core/constant.dart';
import 'package:flutter_base_project/src/core/inputBox.dart';
import 'package:flutter_base_project/src/core/sl_toast.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';
import 'package:flutter_base_project/src/features/contacts/presentation/stores/contact_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:sl_flutter_widgets/components/textfeild/sl_text_field.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  TextEditingController fname = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController countryCode = TextEditingController(text: "91");

  TextEditingController facebook = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController slack = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController skype = TextEditingController();
  ContactStore contactStore = GetIt.instance.get<ContactStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Add Contacts",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: Observer(builder: (context) {
        return Container(
          margin: EdgeInsets.all(mainMargin),
          child: Column(
            children: [
              Expanded(
                child: ListView(children: [
                  InputBox(
                    controller: fname,
                    labelText: "First Name",
                    bgcolor: lightBlack,
                    prefix: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: mainMargin,
                  ),
                  InputBox(
                    controller: lname,
                    labelText: "Last Name",
                    bgcolor: lightBlack,
                    prefix: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: mainMargin,
                  ),
                  InputBox(
                    controller: number,
                    labelText: "Number",
                    bgcolor: lightBlack,
                    prefix: Icon(Icons.phone,
                        color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: mainMargin,
                  ),
                  InputBox(
                    controller: facebook,
                    labelText: "FaceBook",
                    bgcolor: lightBlack,
                    prefix: Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: mainMargin,
                  ),
                  InputBox(
                    controller: instagram,
                    labelText: "Instagram",
                    bgcolor: lightBlack,
                    prefix: Icon(
                      FontAwesomeIcons.instagram,
                      color: Colors.pink,
                    ),
                  ),
                  SizedBox(
                    height: mainMargin,
                  ),
                  InputBox(
                    controller: twitter,
                    labelText: "Twitter",
                    bgcolor: lightBlack,
                    prefix: Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: mainMargin,
                  ),
                  InputBox(
                    controller: slack,
                    labelText: "Slack",
                    bgcolor: lightBlack,
                    prefix: Icon(
                      FontAwesomeIcons.slack,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: mainMargin,
                  ),
                  InputBox(
                    controller: skype,
                    labelText: "Skype",
                    bgcolor: lightBlack,
                    prefix: Icon(
                      FontAwesomeIcons.skype,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: mainMargin,
                  ),
                ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: PrimaryButton(
                  title: "Save",
                  foregroundColor: white,
                  isloading: contactStore.isUpdating,
                  onPressed: () async {
                    var result = await contactStore.addContact(ContactModel(
                        fname: fname.text,
                        lname: lname.text,
                        countryCode: countryCode.text,
                        number: number.text,
                        instagram: instagram.text,
                        facebook: facebook.text,
                        skype: skype.text,
                        slack: slack.text,
                        twiter: twitter.text,
                        country: "india"));

                    if (result.hasException) {
                      SlToast(
                              context: context,
                              msg: result.msg,
                              hasError: result.hasException)
                          .show();
                      log(result.toString());
                    } else {
                      SlToast(
                              context: context,
                              msg: result.msg,
                              hasError: result.hasException)
                          .show();
                      log(result.toString());
                      print("Done");
                    }
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
