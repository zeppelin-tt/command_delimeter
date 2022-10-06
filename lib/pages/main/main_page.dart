import 'package:command_delimeter/localization/localization_constants.dart';
import 'package:command_delimeter/pages/main/components/control_panel.dart';
import 'package:command_delimeter/pages/teams/teams_page.dart';
import 'package:command_delimeter/provider/input_data_provider.dart';
import 'package:command_delimeter/provider/teams_provider.dart';
import 'package:command_delimeter/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController(initialScrollOffset: 0);
  final _pageController = PageController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _inputDataProvider = Provider.of<InputDataProvider>(context);
    final _teamsProvider = Provider.of<TeamsProvider>(context);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          if (_pageController.page == 0.0) return Future.value(true);
          _pageController.goTo(0);
          return Future.value(false);
        },
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Scaffold(
                backgroundColor: Colors.grey[900],
                body: ControlPanel(
                  focusNode: _focusNode,
                  inputController: _inputController,
                  scrollController: _scrollController,
                  onAddName: () {
                    _inputDataProvider.validateName(
                      name: _inputController.text,
                      onEmpty: () {},
                      onExist: () => Notifications.error(context, getTranslated(context, 'error_already_in_the_list')),
                      onSuccess: () {
                        _inputDataProvider.addName(_inputController.text);
                        _inputController.clear();
                        _scrollController.toEnd();
                      },
                    );
                  },
                  onGenerate: () {
                    if (_inputDataProvider.completedTeams) {
                      _teamsProvider.randomizeAndSet(
                        _inputDataProvider.persons,
                        _inputDataProvider.countTeams,
                        _inputDataProvider.captains,
                      );
                      _pageController.goTo(1);
                      FocusScope.of(context).requestFocus(FocusNode());
                      return;
                    }
                    Notifications.error(context, getTranslated(context, 'error_teams_not_completed'));
                  },
                ),
              ),
            ),
            TeamsPage(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

extension PageExtension on PageController {
  void goTo(int pageIndex) {
    if (hasClients) animateToPage(pageIndex, duration: Duration(milliseconds: 600), curve: Curves.easeInOut);
  }
}

extension ScrollExtension on ScrollController {
  void toEnd() {
    if (hasClients) {
      animateTo(
        position.maxScrollExtent,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOut,
      );
    }
  }
}
