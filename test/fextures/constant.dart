import 'package:flutter_base_project/src/core/sl_response.dart';
import 'package:flutter_base_project/src/features/contacts/data/models/contact_model.dart';

var expected = SlResponse<List<ContactModel>>(
    msg: "Done", response: [], hasException: false);

var failure = SlResponse<List<ContactModel>>(
    msg: "error", response: [], hasException: true);