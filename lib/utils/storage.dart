import 'dart:convert';

import 'package:command_delimeter/model/person.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Storage {
  late SharedPreferences _storage;

  SharedPreferences get data => _storage;

  Future<void> init() async => _storage = await SharedPreferences.getInstance();

  int get countTeams => _storage.getInt('countTeams') ?? 2;

  bool get captains => _storage.getBool('captains') ?? true;

  List<Person> get persons => (_storage.getStringList('persons') ?? []).map<Person>((ps) => Person.fromMap(json.decode(ps))).toList();

  void setPersons(List<Person> persons) => _storage.setStringList('persons', persons.map<String>((p) => json.encode(p.toMap())).toList());

  void clearPersons() => _storage.setStringList('persons', []);

  void setCaptains(bool value) => _storage.setBool('captains', value);

  void setCountTeams(int count) => _storage.setInt('countTeams', count);
}
