import 'package:flutter/foundation.dart';

class Location {
  final double latitude;
  final double longitude;
  final String address;
  Location({this.address, @required this.latitude, @required this.longitude});
}
