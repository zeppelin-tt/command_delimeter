import 'dart:math';

import 'package:command_delimeter/localization/localization_constants.dart';
import 'package:command_delimeter/model/person.dart';
import 'package:command_delimeter/pages/teams/components/team_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamsProvider extends ChangeNotifier {
  List<List<Person>> _teams;
  final _rnd;

  TeamsProvider()
      : _teams = [],
        _rnd = Random();

  List<List<Person>> get teams => _teams;

  List<Widget> teamsWidgets(BuildContext context) {
    if (teams.isEmpty) return <Column>[];
    final columns = <Widget>[SizedBox(height: 6.w)];
    var i = 1;
    teams.forEach((team) {
      var itemList = <TeamItem>[];
      itemList.add(TeamItem(text: '${getTranslated(context, 'team_page2')} $i'));
      team.forEach((person) {
        itemList.add(TeamItem(person: person, text: '',));
      });
      columns.add(Column(children: itemList));
      i++;
    });
    return columns;
  }

  bool get isEmpty => _teams.isEmpty;

  void randomizeAndSet(List<Person> persons, int teamCount, bool withCaptains) {
    _teams = _generateCommands(persons, teamCount, withCaptains);
    notifyListeners();
  }

  void setTeams(List<List<Person>> teams) {
    _teams = teams;
    notifyListeners();
  }

  void clearAll() {
    _teams.clear();
    notifyListeners();
  }

  List<List<Person>> _generateCommands(List<Person> allPersons, int teamsCount, bool withCaptains) {
    final persons = List<Person>.from(allPersons);
    final commands = <List<Person>>[];
    for (var i = 0; i < teamsCount; i++) {
      commands.add(<Person>[]);
    }
    var i = 0;
    while (persons.isNotEmpty) {
      var y = 0;
      while (y < teamsCount && persons.isNotEmpty) {
        final person = persons.removeAt(_rnd.nextInt(persons.length));
        commands[y].add(withCaptains && i == 0 ? person.copyWith(captain: true) : person);
        y++;
      }
      i++;
    }
    return commands;
  }
}
