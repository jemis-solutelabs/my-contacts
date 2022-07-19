import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/data/datasource/local_datasource.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';
import 'package:flutter_base_project/src/utils/network_connectivity.dart';

class ContactsRepositoryImpl {
  LocalDataSource localDataSource;
  NetworkConnectivityChecker connectivityChecker;

  ContactsRepositoryImpl(this.localDataSource, this.connectivityChecker);

  Future<SlResponse<List<ContactModel>>> getContacts() async {
    try {
      var data = await localDataSource.getContacts();

      return data;
    } catch (e) {
      return SlResponse(
        msg: "Something went wrong. Please try again later!",
        hasException: true,
        response: []
      );
    }
  }
}
