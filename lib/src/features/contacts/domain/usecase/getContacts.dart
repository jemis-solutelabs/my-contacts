import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';
import 'package:flutter_base_project/src/features/contacts/domain/repositories/contacts_repository.dart';

class GetContracts {
  ContactsRepository contactsRepository;

  GetContracts(this.contactsRepository);

  Future<SlResponse<List<ContactModel>>> getContacts() async {
    return await contactsRepository.getContacts();
  }

  Future<SlResponse<ContactModel?>> addContact(ContactModel contact) async {
    return await contactsRepository.addContact(contact);
  }

  Future<SlResponse<ContactModel?>> updateContact(ContactModel contact) async {
    return await contactsRepository.updateContact(contact);
  }

  Future<SlResponse<ContactModel?>> deleteContact(ContactModel contact) async {
    return await contactsRepository.deleteContact(contact);
  }
}
