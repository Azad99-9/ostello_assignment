import 'package:flutter/widgets.dart';

class SizeConfig {
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double blockSizeHorizontal = 0.0;
  static double blockSizeVertical = 0.0;
  static double textMultiplier = 0.0;
  static double imageSizeMultiplier = 0.0;
  static double heightMultiplier = 0.0;
  static double widthMultiplier = 0.0;
  static double textScaleFactor = 0.0;

  static double screenWidthPercentage(double percentage) {
    return screenWidth * percentage;
  }

  static double screenHeightPercentage(double percentage) {
    return screenHeight * percentage;
  }

  static double textScale(double multiplier) {
    return textMultiplier * multiplier;
  }

  static double imageSizeScale(double multiplier) {
    return imageSizeMultiplier * multiplier;
  }

  static double heightScale(double multiplier) {
    return heightMultiplier * multiplier;
  }

  static double widthScale(double multiplier) {
    return widthMultiplier * multiplier;
  }

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;
    heightMultiplier = blockSizeVertical;
    widthMultiplier = blockSizeHorizontal;
    textScaleFactor = MediaQuery.of(context).textScaleFactor;
  }
}
