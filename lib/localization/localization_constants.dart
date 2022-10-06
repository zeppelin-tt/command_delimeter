import 'package:command_delimeter/localization/delimiter_localization.dart';
import 'package:flutter/cupertino.dart';

String getTranslated(BuildContext context, String key) {
  return DelimiterLocalization.of(context)?.getTranslatedValue(key) ?? '';
}