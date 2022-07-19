import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:flutter_base_project/src/features/contacts/domain/usecase/getContacts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fextures/constant.dart';
import 'getContacts_test.mocks.dart';

@GenerateMocks([ContactsRepository])
void main() {
  late MockContactsRepository contactsRepository;
  late GetContracts getContracts;

  setUp(() {
    contactsRepository = MockContactsRepository();
    getContracts = GetContracts(contactsRepository);
  });

  test("Should return SlResponse with success", () async {
    when(getContracts.getContacts())
        .thenAnswer((realInvocation) async => expected);
    //arange

    var result = await contactsRepository.getContacts();

    //act
    verify(getContracts.getContacts());
    expect(result, expected);

    //assert
  });
}
