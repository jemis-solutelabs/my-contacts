import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/src/core/colors.dart';
import 'package:flutter_base_project/src/core/constant.dart';
import 'package:flutter_base_project/src/features/contacts/presentation/pages/add_contact.dart';
import 'package:flutter_base_project/src/features/contacts/presentation/stores/contact_store.dart';
import 'package:flutter_base_project/src/features/contacts/presentation/widgets/contact_title.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sl_flutter_widgets/components/textfeild/sl_text_field.dart';

class ContactsDashboard extends StatefulWidget {
  const ContactsDashboard({Key? key}) : super(key: key);

  @override
  State<ContactsDashboard> createState() => _ContactsDashboardState();
}

class _ContactsDashboardState extends State<ContactsDashboard> {
  TextEditingController searchController = TextEditingController();

  ContactStore contactStore = GetIt.instance.get<ContactStore>();
  @override
  void initState() {
    // TODO: implement initState
    contactStore.featchContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<AddContacts>(
                  builder: (context) => AddContacts()));
        },
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: transparent,
          title: Text(
            "My Contacts",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: Observer(builder: (context) {
        return Container(
          margin: EdgeInsets.all(mainMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: lightBlack),
                child: Row(
                  children: [
                    SizedBox(
                      width: mainMargin,
                    ),
                    Icon(
                      Icons.search,
                      color: white,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: SLTextField(
                          inputFiledTextStyle:
                              Theme.of(context).textTheme.headline6!,
                          labelTextStyle: Theme.of(context).textTheme.headline6,
                          controller: searchController,
                          labelText: "Search",
                          labelColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mainMargin,
              ),
              Text(
                "Recents",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: mainMargin,
              ),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  itemCount: 15,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CachedNetworkImage(
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://minimaltoolkit.com/images/randomdata/male/2.jpg"),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: subMargin,
                    );
                  },
                ),
              ),
              ListTile(
                leading: Text(
                  "Freinds (" + contactStore.contacts.length.toString() + ")",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "Show All",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: contactStore.contacts.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var contact = contactStore.contacts[index];
                    return ContactTile(contact: contact);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: lightBlack,
                      height: 4,
                      thickness: 2,
                    );
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
