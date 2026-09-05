import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _seedColor = Color(0xFF3D5AFE);

@immutable
class AppThemeTokens extends ThemeExtension<AppThemeTokens> {
const AppThemeTokens({
   required this.pageBackground,
   required this.cardBackground,
   required this.mutedText,
   required this.border,
});

final Color pageBackground;
final Color cardBackground;
final Color mutedText;
final Color border;

@override
AppThemeTokens copyWith({
   Color? pageBackground,
   Color? cardBackground,
   Color? mutedText,
   Color? border,
}) {
   return AppThemeTokens(
     pageBackground: pageBackground ?? this.pageBackground,
     cardBackground: cardBackground ?? this.cardBackground,
     mutedText: mutedText ?? this.mutedText,
     border: border ?? this.border,
   );
}

@override
AppThemeTokens lerp(ThemeExtension<AppThemeTokens>? other, double t) {
   if (other is! AppThemeTokens) return this;
   return AppThemeTokens(
     pageBackground: Color.lerp(pageBackground, other.pageBackground, t)!,
     cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
     mutedText: Color.lerp(mutedText, other.mutedText, t)!,
     border: Color.lerp(border, other.border, t)!,
   );
}
}

ThemeData _buildTheme(Brightness brightness) {
final isLight = brightness == Brightness.light;
final colorScheme = ColorScheme.fromSeed(
   seedColor: _seedColor,
   brightness: brightness,
);

return ThemeData(
   brightness: brightness,
   colorScheme: colorScheme,
   scaffoldBackgroundColor: isLight
       ? const Color(0xFFF7F8FC)
       : const Color(0xFF111318),
   extensions: [
     AppThemeTokens(
       pageBackground: isLight
           ? const Color(0xFFF7F8FC)
           : const Color(0xFF111318),
       cardBackground: isLight
           ? Colors.white
           : const Color(0xFF1D2028),
       mutedText: isLight
           ? const Color(0xFF687080)
           : const Color(0xFFB7BECC),
       border: isLight
           ? const Color(0xFFE1E4EC)
           : const Color(0xFF353A47),
     ),
   ],
   appBarTheme: const AppBarThemeData(
     centerTitle: true,
     elevation: 0,
     scrolledUnderElevation: 0,
     backgroundColor: Colors.transparent,
   ),
   cardTheme: CardThemeData(
     elevation: 0,
     color: isLight ? Colors.white : const Color(0xFF1D2028),
     margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
   ),
   chipTheme: const ChipThemeData(
     showCheckmark: false,
     side: BorderSide.none,
   ),
   listTileTheme: const ListTileThemeData(
     contentPadding: EdgeInsets.symmetric(horizontal: 12),
   ),
);
}

final lightAppTheme = _buildTheme(Brightness.light);
final darkAppTheme = _buildTheme(Brightness.dark);

class AppThemeMode extends Notifier<ThemeMode> {
@override
ThemeMode build() => ThemeMode.system;

void toggle() {
   state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
}
}

final themeModeProvider = NotifierProvider<AppThemeMode, ThemeMode>(
AppThemeMode.new,
);