import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String msg;

  Failure(this.msg);

  List<Object> get props => [msg];
}

class GarphQlFailure extends Failure {
  final String msg;

  GarphQlFailure(this.msg) : super(msg);
}

class LocalFailure extends Failure {
  final String msg;

  LocalFailure(this.msg) : super(msg);
}
