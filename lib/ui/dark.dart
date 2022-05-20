import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ColorMode {
  static const Icon dark = Icon(Icons.brightness_7);
  static const Icon light = Icon(Icons.brightness_3);

  void toggle(BuildContext context) {
    if (DynamicTheme.of(context)?.themeId == AppThemes.dark) {
      DynamicTheme.of(context)?.setTheme(AppThemes.light);
    } else {
      DynamicTheme.of(context)?.setTheme(AppThemes.dark);
    }
  }

  Icon getIcon(BuildContext context) {
    if (DynamicTheme.of(context)?.themeId == AppThemes.dark) {
      return dark;
    } else {
      return light;
    }
  }
}
