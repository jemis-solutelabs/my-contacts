import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/domain/repositories/contacts_repository.dart';

  class GetContracts {
  ContactsRepository contactsRepository;

  GetContracts(this.contactsRepository);

  Future<SlResponse> getContacts() async {
    return await contactsRepository.getContacts();
  }
}
