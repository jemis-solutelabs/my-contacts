import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base_project/src/core/colors.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';

class ContactTile extends StatelessWidget {
  ContactModel contact;
  ContactTile({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: white),
          borderRadius: BorderRadius.circular(22.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.5),
          child: CachedNetworkImage(
              width: 45,
              height: 45,
              fit: BoxFit.cover,
              imageUrl:
                  "https://minimaltoolkit.com/images/randomdata/male/2.jpg"),
        ),
      ),
      title: Text(
        contact.fname + " " + contact.lname,
        style: Theme.of(context).textTheme.headline6!.copyWith(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "+1" + contact.countryCode + " " + contact.number,
        style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
