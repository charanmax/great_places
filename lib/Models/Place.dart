import 'dart:io';
import 'package:flutter/foundation.dart';
import 'Location.dart';

class Place {
  final String id;
  final String title;
  final File image;
  final Location location;

  Place({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.location,
  });
}
