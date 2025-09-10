import 'package:flutter/material.dart';

import 'app_colors.dart';


class AppStyles{
  static const SizeStyles size = SizeStyles();
  static const WeightStyles weight = WeightStyles();


  static TextStyle heading = TextStyle(
    fontSize: size.bodyLarge,
    fontWeight: weight.heading,
  );

  static TextStyle headingRegular = TextStyle(
    fontSize: size.heading,
    fontWeight: weight.regular,
    color: AppColors.secondaryContrast,
  );

  static TextStyle display = TextStyle(
    fontSize: size.display,
    fontWeight: weight.heading,
  );

  static TextStyle bodyEmphasis = TextStyle(
    fontSize: size.body,
    fontWeight: weight.emphasis,
  );

  static TextStyle bodySmallEmphasis = TextStyle(
    fontSize: size.body,
    fontWeight: weight.emphasis,
  );

  static TextStyle bodyBold = TextStyle(
    fontSize: size.body,
    fontWeight: weight.heading,
  );

  static TextStyle bodySmallBold = TextStyle(
    fontSize: size.bodySmall,
    fontWeight:weight.heading,
  );

  static TextStyle bodySmall = TextStyle(
    //color: StudentColors.textPrimary,
    fontSize: AppStyles.size.bodySmall,
    fontWeight: AppStyles.weight.regular,
  );

  static TextStyle small = TextStyle(
      fontSize: size.small
  );

  static TextStyle smallEmphasis = TextStyle(
    fontSize: size.small,
    fontWeight: weight.emphasis,
  );

  static TextStyle bold = TextStyle(
    fontWeight: weight.heading,
  );

  static TextStyle headingLarge = TextStyle(
    fontSize: size.heading,
    fontWeight: weight.heading,
  );

  static TextStyle headingLargeEmphasis = TextStyle(
    fontSize: size.heading,
    fontWeight: weight.emphasis,
  );

  static TextStyle timetable = TextStyle(
    fontWeight: weight.heading,
    fontSize: size.bodySmall,
  );
  static final headingL = TextStyle(
    fontSize: size.heading,
    fontWeight: weight.emphasis,
    color: AppColors.black,
  );

  static final headingS = TextStyle(
    fontSize: size.body,
    fontWeight: weight.medium,
    color: AppColors.black,
  );

  // Body
  static final bodyMedium = TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.regular,
    color: AppColors.black,
  );

  // Label
  static TextStyle labelMediumWithColor(Color color) => TextStyle(
    fontSize: size.small,
    fontWeight: weight.medium,
    color: color,
  );

  // Feedback
  static final feedbackNote = TextStyle(
    fontSize: size.tiny,
    fontWeight: weight.regular,
    color: AppColors.ash,
  );

  // Status
  static TextStyle status(Color color) => TextStyle(
    fontSize: size.small,
    fontWeight: weight.regular,
    color: color,
  );

  // Tabs
  static TextStyle tabLabel(bool isSelected) => TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.heading,
    color: isSelected ? AppColors.primaryMedium : AppColors.graphite,
  );

  // Misc
  static final chartLabel = TextStyle(fontSize: size.tiny);
  static final font10 = TextStyle(fontSize: size.tiny);
  static final font12 = TextStyle(fontSize: size.small);
  static final font14 = TextStyle(fontSize: size.bodySmall);

  static final errorMessage = TextStyle(
    fontSize: size.body,
    fontWeight: weight.regular,
    color: AppColors.error,
  );

  static final dateText = TextStyle(
    fontSize: size.small,
    fontWeight: weight.regular,
    color: AppColors.slate,
  );

  static final timeRange = TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.regular,
    color: AppColors.graphite,
  );

  static final teacherAllocated = TextStyle(
    fontSize: size.tinyPlus,
    fontWeight: weight.regular,
    color: AppColors.slate,
  );

  static final roomNumber = teacherAllocated;

  static final heading16Bold = TextStyle(
    fontSize: size.body,
    fontWeight: weight.heading,
    color: AppColors.white,
  );

  static final body14Grey = TextStyle(
    fontSize: size.bodySmall,
    color: AppColors.black,
  );

  static final bodySmall1 = TextStyle(
    fontSize: size.small,
    color: AppColors.black,
  );

  static TextStyle lineTooltip(Color color) => TextStyle(
    fontSize: size.small,
    fontWeight: weight.heading,
    color: color,
  );

  static final mediumPrimary = TextStyle(
    fontWeight: weight.medium,
    color: AppColors.black,
  );

  static final selectClass = TextStyle(color: AppColors.blackMediumEmphasis);
  static final term = TextStyle(color: AppColors.black);

  static final badgeLarge = TextStyle(
    fontSize: size.tinyPlus,
    fontWeight: weight.heading,
    color: Colors.white,
  );

  static final body14Bold = TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.heading,
    color: AppColors.black,
  );

  static final boldDarkGrey = TextStyle(
    fontWeight: weight.heading,
    color: AppColors.slate,
  );

  static TextStyle passFail(bool isPass) => TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.heading,
    color: isPass ? AppColors.successDark : AppColors.errorDark,
  );

  static final body13Medium = TextStyle(
    fontSize: size.tinyPlus,
    fontWeight: weight.medium,
    color: AppColors.black,
  );

  static final rankLabel = TextStyle(
    fontWeight: weight.heading,
    color: AppColors.white,
  );

  static final bodySmallDark = TextStyle(
    fontSize: size.small,
    color: AppColors.slate,
  );

  static TextStyle lineTooltip1(Color color) => TextStyle(
    color: color,
    fontWeight: weight.heading,
  );

  static TextStyle passFailMedium(bool isPass) => TextStyle(
    fontWeight: weight.medium,
    color: isPass ? AppColors.successDark : AppColors.errorDark,
  );

  //static final bold = TextStyle(fontWeight: weight.heading);

  static TextStyle overallResult(bool overallPass) => TextStyle(
    fontWeight: weight.heading,
    color: overallPass ? AppColors.successDark : AppColors.errorDark,
  );

  static final badge1 = TextStyle(
    fontSize: size.tiny,
    color: Colors.white,
  );

  static final timerText = TextStyle(
    fontSize: size.body,
    fontWeight: weight.regular,
    color: AppColors.error,
  );

  static final body10Primary = TextStyle(
    fontSize: size.tiny,
    fontWeight: weight.regular,
    color: AppColors.black,
  );

  static final body20Primary = TextStyle(
    fontSize: size.heading,
    fontWeight: weight.regular,
    color: AppColors.black,
  );

  static final body16OptionText = TextStyle(
    fontSize: size.body,
    fontWeight: weight.regular,
    color: AppColors.blackHighEmphasis,
  );

  static final smallText1 = TextStyle(
    fontSize: size.tiny,
    color: AppColors.white,
  );

  static final headingLNoColor = TextStyle(
    fontSize: size.heading,
    fontWeight: weight.emphasis,
  );

  static final onlyText1Color = TextStyle(color: AppColors.white);

  static final headingText = TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.regular,
    color: AppColors.black,
  );

  static final whiteFont10 = TextStyle(
    color: AppColors.white,
    fontSize: size.tiny,
  );

  static final headingLPlain = TextStyle(
    fontSize: size.heading,
    fontWeight: weight.emphasis,
  );

  static final body14Black = TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.regular,
    color: AppColors.black,
  );

  static final dropdownText = TextStyle(
    fontSize: size.body,
    color: AppColors.blackHighEmphasis,
  );

  static final heading14 = TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.regular,
    color: AppColors.black,
  );

  static final headingTextSmall = TextStyle(
    fontSize: size.small,
    fontWeight: weight.regular,
    color: AppColors.black,
  );

  static TextStyle selectable(bool isSelected) => TextStyle(
    color: isSelected ? AppColors.white : AppColors.black,
  );

  static final body20Plain = TextStyle(
    fontSize: size.heading,
    fontWeight: weight.regular,
  );

  static final bodyMediumPlain = TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.regular,
  );

  static final body13Primary = TextStyle(
    fontSize: size.tinyPlus,
    fontWeight: weight.regular,
    color: AppColors.primaryDarkest,
  );

  static final body12Black = TextStyle(
    fontSize: size.small,
    fontWeight: weight.regular,
    color: AppColors.black,
  );

  static final body14BlackPlain = TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.regular,
    color: AppColors.black,
  );

  static final body10Black = TextStyle(
    fontSize: size.tiny,
    fontWeight: weight.regular,
    color: AppColors.black,
  );

  static final heading18SemiBoldPrimary2 = TextStyle(
    fontWeight: weight.emphasis,
    fontSize: 18.42,
    color: AppColors.blackHighEmphasis,
  );

  static final body12TextPrimary2 = TextStyle(
    fontSize: size.small,
    fontWeight: weight.regular,
    color: AppColors.blackHighEmphasis,
  );

  static final body10ActionText = TextStyle(
    fontSize: size.tiny,
    fontWeight: weight.medium,
    color: AppColors.tertiaryDarkest,
  );

  static final body10ActionTextBold = TextStyle(
    fontSize: size.tiny,
    fontWeight: weight.emphasis,
    color: AppColors.tertiaryDarkest,
  );

  static final smallGrey = TextStyle(
    fontSize: size.bodySmall,
    fontWeight: weight.medium,
    color: AppColors.textPrimary,
  );

  static const TextStyle textField = TextStyle(
    fontSize: 15,
    color: AppColors.grey,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    color: Color(0xFF2F2F2F),
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textPrimary,
  );


  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle percentage = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle hint = TextStyle(
    fontSize: 14,
    color: AppColors.hint,
  );

  static const TextStyle hint1 = TextStyle(
    fontSize: 16,
    color: AppColors.hint,
  );
  static const TextStyle labelGrey = TextStyle(
    fontSize: 12,
    color: AppColors.iconGray,
  );

  // static const TextStyle boldLarge = TextStyle(
  //   fontSize: 16,
  //   fontWeight: FontWeight.bold,
  //   color: AppColors.textPrimary,
  // );

  static const TextStyle verified = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle notificationText = TextStyle(
    color: AppColors.white,
    fontSize: 9,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle subsectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle inputText = TextStyle(
    fontSize: 14,
    color: AppColors.hintText,
  );

  static const TextStyle uploadLabel = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle uploadButtonText = TextStyle(
    color: AppColors.uploadButtonText,
    fontSize: 13,
  );

  static const sectionHeading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static const label1 = TextStyle(fontSize: 16);
  static const staffId = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 2.0,
  );
  static const uploadLabel1 = TextStyle(fontSize: 16);

}

class SizeStyles{
  const SizeStyles();

  double get micro => 8;
  double get tiny => 10;
  double get small => 12;
  double get bodySmall => 14;
  double get body => 16;
  double get medium =>17;
  double get bodyLarge => 18;
  double get heading => 20;
  double get display => 25;
  double get extraSmall => 11;
  double get tinyPlus => 13;
  double get bodyMedium => 17;
  double get headingLarge => 21;

}

class WeightStyles{
  const WeightStyles();

  // FontWeight get display => FontWeight.bold;
  FontWeight get heading => FontWeight.bold;
  FontWeight get emphasis => FontWeight.w600; //emphasis
  FontWeight get regular => FontWeight.w400; //normal
  FontWeight get medium => FontWeight.w500; //added by vikas
  FontWeight get strong  => FontWeight.w700; //added by vikas
}