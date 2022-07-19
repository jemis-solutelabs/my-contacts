import 'dart:math';

import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/data/datasource/local_datasource.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';
import 'package:flutter_base_project/src/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:flutter_base_project/src/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:flutter_base_project/src/utils/network_connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fextures/constant.dart';
import 'contacts_repository_impl_test.mocks.dart';

@GenerateMocks([LocalDataSource, NetworkConnectivityChecker])
void main() {
  late MockLocalDataSource localDataSource;
  late MockNetworkConnectivityChecker networkConnectivityChecker;
  late ContactsRepositoryImpl contactsRepository;

  setUp(() {
    localDataSource = MockLocalDataSource();
    networkConnectivityChecker = MockNetworkConnectivityChecker();
    contactsRepository =
        ContactsRepositoryImpl(localDataSource, networkConnectivityChecker);
  });

  group("Local datasource testcase", () {
    test("Should return slResponse with true when success", () async {
      when(localDataSource.getContacts())
          .thenAnswer((realInvocation) async => expected);

      var result = await contactsRepository.getContacts();

      verify(localDataSource.getContacts());
      expect(result, expected);
    });
        test("Should return slResponse with false when failure", () async {
      when(localDataSource.getContacts())
          .thenAnswer((realInvocation) async => failure);

      var result = await contactsRepository.getContacts();

      verify(localDataSource.getContacts());
      expect(result, failure);
    });
  });
}
