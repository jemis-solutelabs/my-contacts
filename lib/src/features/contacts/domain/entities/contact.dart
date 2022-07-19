import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  Contact({
    required this.fname,
    required this.lname,
    required this.countryCode,
    required this.number,
    this.facebook,
    this.instagram,
    this.slack,
    this.skype,
    this.twiter,
    required this.country,
  });

  String fname;
  String lname;
  String countryCode;
  String number;
  String? facebook;
  String? instagram;
  String? slack;
  String? skype;
  String? twiter;
  String country;

  @override
  List<Object> get props => [
        fname,
        lname,
        countryCode,
        number,
        facebook!,
        instagram!,
        slack!,
        skype!,
        twiter!,
        country
      ];
}
