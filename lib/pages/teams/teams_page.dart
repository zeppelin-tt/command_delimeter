
import 'package:command_delimeter/localization/localization_constants.dart';
import 'package:command_delimeter/provider/teams_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teamsProvider = Provider.of<TeamsProvider>(context);
    return Material(
      color: Colors.black,
      child: teamsProvider.isEmpty ? _EmptyTeamsView() : ListView(children: teamsProvider.teamsWidgets(context)),
    );
  }
}

class _EmptyTeamsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/skull.svg',
            color: Colors.grey[900],
            height: 400.h,
          ),
          Text(
            getTranslated(context, 'no_teams_yet'),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[900], fontFamily: 'Kill The Noise', fontSize: 52.sp),
          )
        ],
      ),
    );
  }
}
