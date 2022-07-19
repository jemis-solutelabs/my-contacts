import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

abstract class LocalDataSource {
  Future<SlResponse<List<ContactModel>>> getContacts() async =>
      await LocalDataSourceImpl().getContacts();
}

class LocalDataSourceImpl {
  late Isar isar;

  LocalDataSourceImpl() {}

  void initDataBase() async {
    final dir = await getApplicationSupportDirectory();
    isar = await Isar.open(
      schemas: [ContactModelSchema],
      directory: dir.path,
    );
  }

  Future<SlResponse<List<ContactModel>>> getContacts() async {
    try {
      var data = await isar.contactModels.where().findAll();
      return SlResponse(
          msg: "Data fetched successfully",
          hasException: false,
          response: data);
    } catch (e) {
      return SlResponse(
          msg: "Please try again later!", response: [], hasException: true);
    }
  }
}
