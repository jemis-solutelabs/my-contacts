import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';

abstract class ContactsRepository {
  Future<SlResponse<List<ContactModel>>> getContacts();
  Future<SlResponse<ContactModel?>> addContact(ContactModel contact);
  Future<SlResponse<ContactModel?>> updateContact(ContactModel contact);
  Future<SlResponse<ContactModel?>> deleteContact(ContactModel contact);
}
