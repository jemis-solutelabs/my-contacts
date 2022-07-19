import 'package:flutter_base_project/src/core/sl_response.dart';

abstract class ContactsRepository {
  Future<SlResponse> getContacts();
}
