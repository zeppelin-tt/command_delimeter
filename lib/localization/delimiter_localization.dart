import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DelimiterLocalization {
  final Locale locale;

  DelimiterLocalization(this.locale);

  static DelimiterLocalization? of(BuildContext context) {
    return Localizations.of<DelimiterLocalization>(context, DelimiterLocalization);
  }

  late Map<String, String> _localizedValues;

  Future<bool> load() async {
    String jsonStringValues = await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value));
    return true;
  }

  String? getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<DelimiterLocalization> delegate = _DelimiterLocalizationDelegate();
}

class _DelimiterLocalizationDelegate extends LocalizationsDelegate<DelimiterLocalization> {
  const _DelimiterLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru', 'fa', 'ar'].contains(locale.languageCode);

  @override
  Future<DelimiterLocalization> load(Locale locale) async {
    DelimiterLocalization localizations = DelimiterLocalization(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_DelimiterLocalizationDelegate old) => false;
}
