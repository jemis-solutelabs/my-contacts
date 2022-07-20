import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/data/datasource/local_datasource.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';
import 'package:flutter_base_project/src/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:flutter_base_project/src/utils/network_connectivity.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  LocalDataSource localDataSource;
  NetworkConnectivityChecker connectivityChecker;

  ContactsRepositoryImpl(this.localDataSource, this.connectivityChecker);
@override
  Future<SlResponse<List<ContactModel>>> getContacts() async {
    try {
      var data = await localDataSource.getContacts();

      return data;
    } catch (e) {
      return SlResponse(
          msg: "Something went wrong. Please try again later!",
          hasException: true,
          response: []);
    }
  }
@override
  Future<SlResponse<ContactModel?>> addContact(ContactModel contact) async {
    try {
      var data = await localDataSource.addContact(contact);

      return data;
    } catch (e) {
      return SlResponse(
        msg: "Something went wrong. Please try again later!",
        hasException: true,
      );
    }
  }
@override
  Future<SlResponse<ContactModel?>> updateContact(ContactModel contact) async {
    try {
      var data = await localDataSource.updateContact(contact);

      return data;
    } catch (e) {
      return SlResponse(
        msg: "Something went wrong. Please try again later!",
        hasException: true,
      );
    }
  }
@override

  Future<SlResponse<ContactModel?>> deleteContact(ContactModel contact) async {
    try {
      var data = await localDataSource.updateContact(contact);

      return data;
    } catch (e) {
      return SlResponse(
        response: null,
        msg: "Something went wrong. Please try again later!",
        hasException: true,
      );
    }
  }
}
