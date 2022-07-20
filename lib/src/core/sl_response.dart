import 'package:equatable/equatable.dart';

class SlResponse<T> extends Equatable {
  ///message of the response
  final String msg;
  //return [True] if response has exception
  final bool hasException;

  final List<Exception> exceptions;

  ///return list of exceptions
  final T? response;

  /// object of expected return type

  @override
  List<Object> get props => hasException
      ? [msg, hasException, exceptions]
      : [msg, hasException, exceptions, response!];

  SlResponse(
      {required this.msg,
      this.exceptions = const [],
      this.hasException = false,
       this.response});
}
