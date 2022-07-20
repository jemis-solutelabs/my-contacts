import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/data/datasource/local_datasource.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';
import 'package:flutter_base_project/src/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:flutter_base_project/src/features/contacts/domain/usecase/getContacts.dart';
import 'package:flutter_base_project/src/utils/network_connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'contact_store.g.dart';

Future initContactStore() async {
  GetIt.instance.registerSingleton(GetContracts(ContactsRepositoryImpl(
      LocalDataSourceImpl(), NetworkConnectivity(Connectivity()))));
  GetIt.instance.registerSingleton(ContactStore());
  return true;
}

class ContactStore = ContactStoreBase with _$ContactStore;

abstract class ContactStoreBase with Store {
  @observable
  bool loading = false;
  @computed
  bool get isLoading => loading;
  @observable
  bool updating = false;
  @computed
  bool get isUpdating => updating;
  @observable
  ObservableList<ContactModel> contacts = ObservableList<ContactModel>();

  ContactStoreBase() {
    featchContacts();
  }
  @action
  void setLoading(bool value) {
    loading = value;
  }

  @action
  void setUpdating(bool value) {
    updating = value;
  }

  @action
  Future featchContacts() async {
    setLoading(true);
    var getConntacts = GetIt.instance.get<GetContracts>();

    var result = await getConntacts.getContacts();

    if (result.hasException) {
    } else {
      contacts.addAll(result.response!);
      log(contacts.toString());
      setLoading(false);
    }
  }

  @action
  Future<SlResponse<ContactModel?>> addContact(ContactModel contact) async {
    {
      setUpdating(true);
      var getConntacts = GetIt.instance.get<GetContracts>();

      var result = await getConntacts.addContact(contact);
      if (result.hasException) {
      } else {
        contacts.add(result.response!);
      }

      setUpdating(false);
      return result;
    }
  }

  @action
  Future<SlResponse<ContactModel?>> updateContact(ContactModel contact) async {
    {
      setUpdating(true);
      var getConntacts = GetIt.instance.get<GetContracts>();

      var result = await getConntacts.updateContact(contact);
      setUpdating(false);
      return result;
    }
  }

  @action
  Future<SlResponse<ContactModel?>> deleteContact(ContactModel contact) async {
    {
      setUpdating(true);
      var getConntacts = GetIt.instance.get<GetContracts>();

      var result = await getConntacts.deleteContact(contact);
      setUpdating(false);
      return result;
    }
  }
}
