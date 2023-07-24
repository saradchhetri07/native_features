import 'package:flutter/material.dart';
import 'package:native_features/helpers/db_helper.dart';
import 'package:native_features/models/place.dart';
import 'dart:io';

class GreatPlace with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(File imageFile, String pickedTitle) {
    Place newPlace = Place(
        id: DateTime.now().toIso8601String(),
        title: pickedTitle,
        location: null,
        image: imageFile);

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchandSetPlaces() async {
    final dataList = await DBHelper.getData("user_places");
    _items = dataList
        .map((items) => Place(
            id: items['id'],
            title: items['title'],
            location: null,
            image: File(items['image'])))
        .toList();
    notifyListeners();
  }
}
