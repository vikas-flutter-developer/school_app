import 'package:flutter/material.dart';

class AppColors{
  AppColors._(); // Private constructor to prevent instantiation

  // --- Brand Colors ---

  // Primary Color Palette (10 Shades: from lightest to darkest)
  // Only colors derived from your original list are populated.
  // Other shades are placeholders for you to define.
  static const Color primaryLavender = Color(0xFFB7B4E2);
  static const Color primaryLightest = Color(0xFFEEECF8); // Derived from original bgAccent
  static Color primaryLighter = Colors.lightBlue.shade100; // Derived from original bgChapterTile
  static const Color primaryLight = Color(0xFF928FD3);    // Your designated 'catch' color
  static const Color primary = Color(0xFF3B3692);         // Your core base primary color
  static const Color primaryMedium = Color(0xFF4A44B6);   // Derived from original borderButton, buttonPrimary
  static const Color primaryDark = Color(0xFF3F2B96);     // Derived from original buttonAdminPrimary
  static Color primaryDarker = Colors.blue.shade800; // Derived from original textChapterAccent, tableHeader
  static Color primaryDarkest = Colors.blue.shade900; // Derived from original buttonSave
  static const Color primaryDarkAccent  = Color(0xff2C296D);
  static const Color primaryBright = Color(0xFF0000F5);
  static const Color primaryContrast = Color(0xFF06027C); // Placeholder for a very dark contrast shade

  // Secondary Color Palette (10 Shades: from lightest to darkest)
  // Only colors derived from your original list are populated.
  // Other shades are placeholders for you to define.
  static const Color secondaryAccentLight = Color(0xFFEDE7F6);
  static const Color secondaryLightest = Color(0xFFD0F0FF); // Derived from original attendanceHalfDay
  static const Color secondaryLighter = Color(0xFFB39DDB);  // Derived from original bgFeedTile
  static const Color secondaryLight = Color(0xFFC049FB);    // Derived from original borderDividerSecondary
  static const Color secondaryPale = Color(0xFFABDEE3);     // Derived from original bgChapterTile3
  static const Color secondary = Colors.deepPurpleAccent; // Using Colors.deepPurpleAccent as base secondary
  static const Color secondaryMedium = Color(0xFF673AB7);   // Derived from original attendancePiePresent
  static const Color secondaryDark = Color(0xFF4A148C);    // Placeholder for a darker shade
  static const Color secondaryDarker = Color(0xFF6A1B9A);  // Placeholder for an even darker shade
  static const Color secondaryDarkest = Color(0xFF6A0DAD); // Placeholder for a very deep shade
  static const Color secondaryExtreme = Color(0x7F663399); // Placeholder for a very deep shade
  static const Color secondaryContrast = Color(0xFF6200EE); // Placeholder for a strong contrast shade

  // Tertiary Color Palette (10 Shades: from lightest to darkest)
  // Only colors derived from your original list are populated.
  // Other shades are placeholders for you to define.
  static Color tertiaryLightest = Colors.blue.shade50; // Derived from original bgTableAlt1
  static Color tertiaryLighter = Colors.lightBlue.shade100; // Derived from original bgChapterTile
  static const Color tertiaryLight = Colors.lightBlue;       // Derived from original borderPrimary
  static const Color tertiaryPale = Color(0xFF607D8B);     // Placeholder for a softer base
  static Color tertiaryAccent = Colors.blueAccent.shade200;
  static Color tertiaryAccentLight = Colors.blueAccent.shade100;
  static const Color tertiaryAccentDark = Colors.blueAccent;
  static const Color tertiary = Colors.blue;                 // Derived from original iconSecondary, borderFile, textProfile, calenderBgToday
  static const Color tertiaryMedium = Color.fromRGBO(2, 183, 223, 1);  // Placeholder for a slightly deeper shade
  // static const Color tertiaryDark = Color(0x...);    // Placeholder for a darker shade
  static const Color tertiaryDarker = Color(0xFF1A237E);  // Placeholder for an even darker shade
  static const Color tertiaryDarkest = Color.fromRGBO(36, 40, 55, 1,); // Placeholder for a very deep shade
  // static const Color tertiaryContrast = Color(0x...); // Placeholder for a strong contrast shade

  // Accent Color (Specific 'catch' color)
  static const Color accent = Color(0xFF928FD3); // Your designated 'catch' color, also bgFeedIcons
  static const Color accentLight = Color.fromRGBO(191, 188, 239, 1);
  static const Color accentDark = Color(0x7FDDA0DD);
  static const Color accentPink = Colors.pinkAccent;
  // --- Neutrals ---

  // Whites (using Material Design white and light gray shades)
  static const Color white = Colors.white;              // From original bgPrimary, textOnColor
  static const Color frostWhite = Colors.white70;
  static const Color ivory = Color.fromRGBO(237, 236, 248, 1);         // Custom subtle warm white
  static Color linen = Colors.grey.shade100;      // From original bgTableAlt2
  static Color parchment = Colors.grey.shade200;  // From original bgSecondary

  // Blacks (using Material Design black constants and custom solid tones)
  static const Color black = Colors.black;               // From original textPrimary, borderTertiary
  static const Color blackHighEmphasis = Colors.black87; // From original textErrorTitle, calenderBgOnfocus
  static const Color blackMediumEmphasis = Colors.black54; // From original textTertiary
  static const Color blackTextSubtle = Colors.black45;   // Common Flutter black (added for completeness)
  static const Color blackDisabled = Colors.black38;     // Common Flutter black (added for completeness)
  static const Color blackHint = Colors.black26;         // From original tableBorder
  static const Color blackDivider = Colors.black12;      // Common Flutter black (added for completeness)
  static const Color jet = Color(0xFF1F1F1F);            // Custom very dark, near-black
  static const Color obsidian = Color(0xFF2C2C2C);       // Custom deep, rich black tone
  static const Color charcoal = Color(0xFF333333);       // Custom dark, primary text color

  // Grays (using Material Design grey shades and custom evocative names)
  static Color graphite = Colors.grey.shade800;
  static Color slate = Colors.grey.shade700;    // From original textAccent, iconAccent
  static Color stone = Colors.grey.shade600;    // From original textErrorDesc
  static const Color ash = Colors.grey;              // From original textSecondary, iconPrimary
  static Color silver = Colors.grey.shade400;   // From original borderSecondary
  static Color cloud = Colors.grey.shade300;    // From original progIndicatorPrimary
  // static const Color mist = Color(0xFF989898);        // From original borderDividerPrimary

  // --- Semantic/State Colors ---
  // These colors convey specific meanings (success, warning, error, info).
  static const Color success = Colors.green;          // From original textSuccess, iconSuccess, progIndicatorSecondary
  static const Color successLight = Color(0xFFDEFFD8);          // From original textSuccess, iconSuccess, progIndicatorSecondary
  static  Color successDark = Colors.green.shade700;          // From original textSuccess, iconSuccess, progIndicatorSecondary
  static Color successAccent = Colors.green.shade400;
  static const Color warning = Colors.amber;          // From original calenderBgSelected
  static const Color warningLight = Color(0xFFFFB74D);         // From original calenderBgSelected
  static const Color warningAccent = Color.fromRGBO(212, 129, 12, 1);
  static const Color warningSecondary = Color.fromRGBO(241, 162, 66, 1);
  static const Color pending = Colors.orange;
  static const Color pendingLight = Color(0xFFEFD53D);
  static const Color pendingAlt = Colors.pinkAccent;
  static const Color error = Colors.red;              // From original bgError, textError, buttonCancel, notificationBadge, textLogout
  static const Color errorLight = Color(0xFFFFE0E0);              // From original bgError, textError, buttonCancel, notificationBadge, textLogout
  static Color errorDark = Colors.red.shade700;              // From original bgError, textError, buttonCancel, notificationBadge, textLogout
  static const Color errorAccent = Colors.redAccent;  // From original iconError
  static const Color info = Colors.blue;
  static Color infoDark = Colors.blue.shade700;// From original progIndicatorTertiary, notificationText
  // --- Specific Feature/Component Colors (where a general neutral or brand color doesn't fit semantically) ---

  // Payment UI
  static const Color paymentLeadingBg = Color.fromRGBO(254, 190, 186, 1); // From original bgPaymentLeading

  static const Color goldMedal = Color(0xFFFFB300);
  static const Color silverMedal = Color(0xFF9E9E9E);
  static const Color bronzeMedal = Color(0xFF8D6E63);

  // Chapter Tiles (specific background variations)
  static Color chapterTile1Bg = Colors.lightBlue.shade100; // From original bgChapterTile
  static Color chapterTile2Bg = Colors.amber.shade100; // From original bgChapterTile2
  static const Color chapterTile3Bg = Color(0xFFABDEE3);     // From original bgChapterTile3

  // Attendance
  static const Color attendancePresent = Color(0xFFB2FFB5); // From original attendancePresent
  static const Color attendanceAbsent = Color(0xFFFFADA4); // From original attendanceAbsent
  static const Color attendanceHoliday = Color(0xFF00BFFF); // From original attendanceHoliday
  static const Color attendanceHalfDay = Color(0xFFD0F0FF); // From original attendanceHalfDay
  static const Color attendanceLateArrival = Color(0xFFB0E08E); // From original attendanceLateArrival
  static const Color attendanceOutdoor = Color(0xFFE6B8E9); // From original attendanceOutdoor
  static const Color attendancePiePresent = Color(0xFF673AB7); // From original attendancePiePresent
  static Color attendancePieAbsent = Colors.blue.shade200; // From original attendancePieAbsent

  // --- Utility Colors (Shadows) ---
  static const Color shadowDefault = Color(0x339E9E9E); // From original shadowPrimary
  static const Color shadowStrong = Color(0x4D9E9E9E); // From original shadowSecondary

  static LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDarker, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // --- Chart Colors ----
  static const Color barChartColor1 = Color(0xFFC5CAE9);
  static const Color barChartColor2 = Color(0xFF3F51B5);
  static const Color barChartFailColor1 = Color(0xFFF48FB1);
  static const Color barChartFailColor2 = Color(0xFFE91E63);
  static const Color lineChartColor = Color(0xFF9575CD);
  static const Color gridLineColor = Color(0xFFE0E0E0);
  static const Color dottedLineColor = Color(0xFFF48FB1);
  static const Color printIconColor = Color(0xFF607D8B);
  static const Color lineChartAltColor = Color(0xFF7E57C2);

  static const Color transparent = Colors.transparent;

  //noticeColors
  static const Color ptmStatus = Color.fromRGBO(12, 212, 19, 1);
  static const Color ptmBar = Color.fromRGBO(207, 222, 119, 1);

  static const Color holidayStatus = Color.fromRGBO(62, 12, 212, 1);
  static const Color holidayBar = Color.fromRGBO(120, 119, 222, 1);

  static const Color resultBar = Color.fromRGBO(222, 119, 119, 1);

  static const Color raisedColor = Color(0xFFa362ea);
  static const Color resolvedColor = Color(0xFF4ecdc4);
  static const Color pendingColor = Color(0xFFff9a69);

  static Color inventoryIconBg = Colors.orange.shade100;
  static Color inventoryIcon = Colors.orange.shade700;

  static const Color secondaryDivider = Color.fromRGBO(213, 180, 133, 1);

  static Color withOpacity(Color base, double opacity) => base.withOpacity(opacity);
  static List<Color> lineGradient(Color base) => [base.withOpacity(0.8), base];
  static List<Color> areaGradient(Color base) => [base.withOpacity(0.3), base.withOpacity(0.0)];

  static const Color limeGreen = Color(0xFFB9E844);             // Bright Lime Green
  static const Color mintGreen = Color(0xFFA4FFD2);             // Mint Green
  static const Color below50 = Color(0xA1B9F6CA);               // Light Teal/Green (Below 50%)
  static const Color segmentLime = Color(0xFFCDDC39);

  static const Color primary1 = Color(0xFFAFADDF);
  static const Color primary2 = Color(0xFF1D4ED8);
  static const Color secondary2 = Color(0xFF6B7280);

  // ✅ Unified Grey Base for repeated colors like hint, text, uploadButton
  static const Color greyBase = Color(0xFFB0B0B0); // used for: hint, hintText, uploadButtonText, greyText
  static const Color hint = greyBase;
  static const Color hintText = greyBase;
  static const Color uploadButtonText = greyBase;
  static const Color greyText = greyBase;
  static const Color grey = greyBase;

  static const Color textPrimary = Colors.black87;
  static const Color cardBackground = Color(0xFFF6F8FF);
  static const Color iconGray = Colors.grey;
  static const Color selected = Color(0xFF635BFF);
  static const Color border =  Color(0xFFE5E5E5);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color primaryText = Colors.black;
  static const Color textPrimary1 = Color(0xFF333333);
  static const Color imageErrorBackground = Color(0xFFD9D9D9);
  static const Color verified = Colors.green;
  static const Color notVerified = Colors.red;
  static const Color attendanceBlue = Color(0xFF1667FF);
  static const Color leaveCyan = Color(0xFF84D6E5);
  static const Color halfDayRed = Color(0xFFF06E6E);
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color placeholderGrey = Color(0xFFD1D5DB);
  static const Color borderFocused = Color(0xFFCDCDCD);
  static const Color containerDecoration = Color(0xFF8EBBF7);
  static const Color bluishLightBackgroundshilu = Color(0xFFE0E5FF); // Exact #E0E5FF

}


/*    old app colors */
// import 'package:flutter/material.dart';
//
// class AppColors{
//   AppColors._(); // Private constructor to prevent instantiation
//
//   // --- Brand Colors ---
//
//   // Primary Color Palette (10 Shades: from lightest to darkest)
//   // Only colors derived from your original list are populated.
//   // Other shades are placeholders for you to define.
//   static const Color primaryLightest = Color(0xFFEEECF8); // Derived from original bgAccent
//   static Color primaryLighter = Colors.lightBlue.shade100; // Derived from original bgChapterTile
//   static const Color primaryLight = Color(0xFF928FD3);    // Your designated 'catch' color
//   static const Color primary = Color(0xFF3B3692);         // Your core base primary color
//   static const Color primaryMedium = Color(0xFF4A44B6);   // Derived from original borderButton, buttonPrimary
//   static const Color primaryDark = Color(0xFF3F2B96);     // Derived from original buttonAdminPrimary
//   static Color primaryDarker = Colors.blue.shade800; // Derived from original textChapterAccent, tableHeader
//   static Color primaryDarkest = Colors.blue.shade900; // Derived from original buttonSave
//   static const Color primaryDarkAccent  = Color(0xff2C296D);
//   static const Color primaryBright = Color(0xFF0000F5);
//   static const Color primaryContrast = Color(0xFF06027C); // Placeholder for a very dark contrast shade
//
//   // Secondary Color Palette (10 Shades: from lightest to darkest)
//   // Only colors derived from your original list are populated.
//   // Other shades are placeholders for you to define.
//   static const Color secondaryAccentLight = Color(0xFFEDE7F6);
//   static const Color secondaryLightest = Color(0xFFD0F0FF); // Derived from original attendanceHalfDay
//   static const Color secondaryLighter = Color(0xFFB39DDB);  // Derived from original bgFeedTile
//   static const Color secondaryLight = Color(0xFFC049FB);    // Derived from original borderDividerSecondary
//   static const Color secondaryPale = Color(0xFFABDEE3);     // Derived from original bgChapterTile3
//   static const Color secondary = Colors.deepPurpleAccent; // Using Colors.deepPurpleAccent as base secondary
//   static const Color secondaryMedium = Color(0xFF673AB7);   // Derived from original attendancePiePresent
//   static const Color secondaryDark = Color(0xFF4A148C);    // Placeholder for a darker shade
//   static const Color secondaryDarker = Color(0xFF6A1B9A);  // Placeholder for an even darker shade
//   static const Color secondaryDarkest = Color(0xFF6A0DAD); // Placeholder for a very deep shade
//   static const Color secondaryExtreme = Color(0x7F663399); // Placeholder for a very deep shade
//   static const Color secondaryContrast = Color(0xFF6200EE); // Placeholder for a strong contrast shade
//
//   // Tertiary Color Palette (10 Shades: from lightest to darkest)
//   // Only colors derived from your original list are populated.
//   // Other shades are placeholders for you to define.
//   static Color tertiaryLightest = Colors.blue.shade50; // Derived from original bgTableAlt1
//   static Color tertiaryLighter = Colors.lightBlue.shade100; // Derived from original bgChapterTile
//   static const Color tertiaryLight = Colors.lightBlue;       // Derived from original borderPrimary
//   static const Color tertiaryPale = Color(0xFF607D8B);     // Placeholder for a softer base
//   static Color tertiaryAccent = Colors.blueAccent.shade200;
//   static Color tertiaryAccentLight = Colors.blueAccent.shade100;
//   static const Color tertiaryAccentDark = Colors.blueAccent;
//   static const Color tertiary = Colors.blue;                 // Derived from original iconSecondary, borderFile, textProfile, calenderBgToday
//   static const Color tertiaryMedium = Color.fromRGBO(2, 183, 223, 1);  // Placeholder for a slightly deeper shade
//   // static const Color tertiaryDark = Color(0x...);    // Placeholder for a darker shade
//   static const Color tertiaryDarker = Color(0xFF1A237E);  // Placeholder for an even darker shade
//   static const Color tertiaryDarkest = Color.fromRGBO(36, 40, 55, 1,); // Placeholder for a very deep shade
//   // static const Color tertiaryContrast = Color(0x...); // Placeholder for a strong contrast shade
//
//   // Accent Color (Specific 'catch' color)
//   static const Color accent = Color(0xFF928FD3); // Your designated 'catch' color, also bgFeedIcons
//   static const Color accentLight = Color.fromRGBO(191, 188, 239, 1);
//   static const Color accentDark = Color(0x7FDDA0DD);
//   static const Color accentPink = Colors.pinkAccent;
//   // --- Neutrals ---
//
//   // Whites (using Material Design white and light gray shades)
//   static const Color white = Colors.white;              // From original bgPrimary, textOnColor
//   static const Color frostWhite = Colors.white70;
//   static const Color ivory = Color.fromRGBO(237, 236, 248, 1);         // Custom subtle warm white
//   static Color linen = Colors.grey.shade100;      // From original bgTableAlt2
//   static Color parchment = Colors.grey.shade200;  // From original bgSecondary
//
//   // Blacks (using Material Design black constants and custom solid tones)
//   static const Color black = Colors.black;               // From original textPrimary, borderTertiary
//   static const Color blackHighEmphasis = Colors.black87; // From original textErrorTitle, calenderBgOnfocus
//   static const Color blackMediumEmphasis = Colors.black54; // From original textTertiary
//   static const Color blackTextSubtle = Colors.black45;   // Common Flutter black (added for completeness)
//   static const Color blackDisabled = Colors.black38;     // Common Flutter black (added for completeness)
//   static const Color blackHint = Colors.black26;         // From original tableBorder
//   static const Color blackDivider = Colors.black12;      // Common Flutter black (added for completeness)
//   static const Color jet = Color(0xFF1F1F1F);            // Custom very dark, near-black
//   static const Color obsidian = Color(0xFF2C2C2C);       // Custom deep, rich black tone
//   static const Color charcoal = Color(0xFF333333);       // Custom dark, primary text color
//
//   // Grays (using Material Design grey shades and custom evocative names)
//   static Color graphite = Colors.grey.shade800;
//   static Color slate = Colors.grey.shade700;    // From original textAccent, iconAccent
//   static Color stone = Colors.grey.shade600;    // From original textErrorDesc
//   static const Color ash = Colors.grey;              // From original textSecondary, iconPrimary
//   static Color silver = Colors.grey.shade400;   // From original borderSecondary
//   static Color cloud = Colors.grey.shade300;    // From original progIndicatorPrimary
//   // static const Color mist = Color(0xFF989898);        // From original borderDividerPrimary
//
//   // --- Semantic/State Colors ---
//   // These colors convey specific meanings (success, warning, error, info).
//   static const Color success = Colors.green;          // From original textSuccess, iconSuccess, progIndicatorSecondary
//   static const Color successLight = Color(0xFFDEFFD8);          // From original textSuccess, iconSuccess, progIndicatorSecondary
//   static  Color successDark = Colors.green.shade700;          // From original textSuccess, iconSuccess, progIndicatorSecondary
//   static Color successAccent = Colors.green.shade400;
//   static const Color warning = Colors.amber;          // From original calenderBgSelected
//   static const Color warningLight = Color(0xFFFFB74D);         // From original calenderBgSelected
//   static const Color warningAccent = Color.fromRGBO(212, 129, 12, 1);
//   static const Color warningSecondary = Color.fromRGBO(241, 162, 66, 1);
//   static const Color pending = Colors.orange;
//   static const Color pendingLight = Color(0xFFEFD53D);
//   static const Color pendingAlt = Colors.pinkAccent;
//   static const Color error = Colors.red;              // From original bgError, textError, buttonCancel, notificationBadge, textLogout
//   static const Color errorLight = Color(0xFFFFE0E0);              // From original bgError, textError, buttonCancel, notificationBadge, textLogout
//   static Color errorDark = Colors.red.shade700;              // From original bgError, textError, buttonCancel, notificationBadge, textLogout
//   static const Color errorAccent = Colors.redAccent;  // From original iconError
//   static const Color info = Colors.blue;
//   static Color infoDark = Colors.blue.shade700;// From original progIndicatorTertiary, notificationText
//   // --- Specific Feature/Component Colors (where a general neutral or brand color doesn't fit semantically) ---
//
//   // Payment UI
//   static const Color paymentLeadingBg = Color.fromRGBO(254, 190, 186, 1); // From original bgPaymentLeading
//
//   static const Color goldMedal = Color(0xFFFFB300);
//   static const Color silverMedal = Color(0xFF9E9E9E);
//   static const Color bronzeMedal = Color(0xFF8D6E63);
//
//   // Chapter Tiles (specific background variations)
//   static Color chapterTile1Bg = Colors.lightBlue.shade100; // From original bgChapterTile
//   static Color chapterTile2Bg = Colors.amber.shade100; // From original bgChapterTile2
//   static const Color chapterTile3Bg = Color(0xFFABDEE3);     // From original bgChapterTile3
//
//   // Attendance
//   static const Color attendancePresent = Color(0xFFB2FFB5); // From original attendancePresent
//   static const Color attendanceAbsent = Color(0xFFFFADA4); // From original attendanceAbsent
//   static const Color attendanceHoliday = Color(0xFF00BFFF); // From original attendanceHoliday
//   static const Color attendanceHalfDay = Color(0xFFD0F0FF); // From original attendanceHalfDay
//   static const Color attendanceLateArrival = Color(0xFFB0E08E); // From original attendanceLateArrival
//   static const Color attendanceOutdoor = Color(0xFFE6B8E9); // From original attendanceOutdoor
//   static const Color attendancePiePresent = Color(0xFF673AB7); // From original attendancePiePresent
//   static Color attendancePieAbsent = Colors.blue.shade200; // From original attendancePieAbsent
//
//   // --- Utility Colors (Shadows) ---
//   static const Color shadowDefault = Color(0x339E9E9E); // From original shadowPrimary
//   static const Color shadowStrong = Color(0x4D9E9E9E); // From original shadowSecondary
//
//   static LinearGradient primaryGradient = LinearGradient(
//     colors: [primaryDarker, primaryLight],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
//
//   // --- Chart Colors ----
//   static const Color barChartColor1 = Color(0xFFC5CAE9);
//   static const Color barChartColor2 = Color(0xFF3F51B5);
//   static const Color barChartFailColor1 = Color(0xFFF48FB1);
//   static const Color barChartFailColor2 = Color(0xFFE91E63);
//   static const Color lineChartColor = Color(0xFF9575CD);
//   static const Color gridLineColor = Color(0xFFE0E0E0);
//   static const Color dottedLineColor = Color(0xFFF48FB1);
//   static const Color printIconColor = Color(0xFF607D8B);
//   static const Color lineChartAltColor = Color(0xFF7E57C2);
//
//   static const Color transparent = Colors.transparent;
//
//   //noticeColors
//   static const Color ptmStatus = Color.fromRGBO(12, 212, 19, 1);
//   static const Color ptmBar = Color.fromRGBO(207, 222, 119, 1);
//
//   static const Color holidayStatus = Color.fromRGBO(62, 12, 212, 1);
//   static const Color holidayBar = Color.fromRGBO(120, 119, 222, 1);
//
//   static const Color resultBar = Color.fromRGBO(222, 119, 119, 1);
//
//   static const Color raisedColor = Color(0xFFa362ea);
//   static const Color resolvedColor = Color(0xFF4ecdc4);
//   static const Color pendingColor = Color(0xFFff9a69);
//
//   static Color inventoryIconBg = Colors.orange.shade100;
//   static Color inventoryIcon = Colors.orange.shade700;
//
//   static const Color secondaryDivider = Color.fromRGBO(213, 180, 133, 1);
//
//   static Color withOpacity(Color base, double opacity) => base.withOpacity(opacity);
//   static List<Color> lineGradient(Color base) => [base.withOpacity(0.8), base];
//   static List<Color> areaGradient(Color base) => [base.withOpacity(0.3), base.withOpacity(0.0)];
//
//   static const Color limeGreen = Color(0xFFB9E844);             // Bright Lime Green
//   static const Color mintGreen = Color(0xFFA4FFD2);             // Mint Green
//   static const Color below50 = Color(0xA1B9F6CA);               // Light Teal/Green (Below 50%)
//   static const Color segmentLime = Color(0xFFCDDC39);
// }
