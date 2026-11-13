import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../models/parameter.dart';
import '../models/supply.dart';

class InventoryStore extends ChangeNotifier {
  final List<Parameter> _parameters = [
    const Parameter(
        name: 'MELEE', className: 'BASE_WEAPON', color: Color(0xFFFF40FF)),
    const Parameter(
        name: 'ASSAULT RIFLE',
        className: 'BASE_WEAPON',
        color: Color(0xFFA0FF40)),
  ];
  final List<Supply> _supplies   =  [];

  UnmodifiableListView<Parameter> get parameters =>   
      UnmodifiableListView(_parameters);
  UnmodifiableListView<Supply> get supplies => UnmodifiableListView(_supplies);

  bool parameterNameExists(String name) => _parameters 
      .any((p) => p.name.toLowerCase() == name.trim().toLowerCase());

  void addParameter(Parameter parameter) {
    _parameters.insert(0, parameter);
    notifyListeners();
  }

  void addSupply(Supply supply) {
    _supplies.insert(0, supply);
    notifyListeners();
  }
}
