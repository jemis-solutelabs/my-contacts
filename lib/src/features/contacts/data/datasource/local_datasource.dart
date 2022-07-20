import 'dart:developer';

import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

abstract class LocalDataSource {
  Future<SlResponse<List<ContactModel>>> getContacts() async =>
      await LocalDataSourceImpl().getContacts();

  Future<SlResponse<ContactModel?>> addContact(ContactModel contact) async =>
      await LocalDataSourceImpl().addContact(contact);
  Future<SlResponse<ContactModel?>> updateContact(ContactModel contact) async =>
      await LocalDataSourceImpl().updateContact(contact);
  Future<SlResponse<bool>> deleteContact(ContactModel contact) async =>
      await LocalDataSourceImpl().deleteContact(contact);
}

class LocalDataSourceImpl implements LocalDataSource {
  late Isar isar;

  LocalDataSourceImpl() {
    initDataBase();
  }

  void initDataBase() async {
    final dir = await getApplicationSupportDirectory();
    isar = await Isar.open(
      schemas: [ContactModelSchema],
      directory: dir.path,
    );
    log("ISAR opend");
  }

  @override
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

  @override
  Future<SlResponse<ContactModel?>> addContact(ContactModel contact) async {
    // TODO: implement addContact
    try {
      var result = await isar.writeTxn<ContactModel>((isar) async {
        var id = await isar.contactModels.put(contact);

        contact.id = id;
        return contact;
      });

      return SlResponse(
          msg: "Contact added successfully!",
          hasException: false,
          response: result);
    } catch (e) {
      log(e.toString());
      return SlResponse(
        msg: "Try again later:0",
        hasException: true,
      );
    }
  }

  @override
  Future<SlResponse<ContactModel?>> updateContact(ContactModel contact) async {
    // TODO: implement addContact
    try {
      var result = await isar.writeTxn<ContactModel>((isar) async {
        await isar.contactModels.put(contact);

        return contact;
      });

      return SlResponse(
          msg: "Contact updated successfully!",
          hasException: false,
          response: result);
    } catch (e) {
      return SlResponse(
        msg: "Try again later",
        hasException: true,
      );
    }
  }

  @override
  Future<SlResponse<bool>> deleteContact(ContactModel contact) async {
    try {
      await isar.contactModels.delete(contact.id!);

      return SlResponse(
          msg: "Contact deleted successfully",
          hasException: false,
          response: true);
    } catch (e) {
      return SlResponse(
          msg: "Contact deleted successfully",
          hasException: true,
          response: false);
    }
  }
}
