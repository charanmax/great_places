import '../Models/Place.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addItem(String title, File image) {
    final newPlace = Place(
      image: image,
      location: null,
      title: title,
      id: DateTime.now().toString(),
    );
    _places.add(newPlace);
    print(_places);
    notifyListeners();
  }
}
