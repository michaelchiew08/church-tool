import 'package:flutter/material.dart';

double responsivePadding(double displayWidth) => displayWidth * 0.03;

const double singlePageFixedHeight = 650;
const double singlePageTextSize = 18;

/// trigger from classic drawer to drawer fixed open
const double pixelFixedDrawer = 650;

/// trigger from 1 column  to 2 columns (just inner view). Should be greater
/// than `pixelFixedDrawer`
const double pixelWidth1Column = 700;

/// trigger from 2 columns to 3 columns (just inner view). Should be greater
/// than `pixelWidth1Column`
const double pixelWidth2Columns = 1000;

/// trigger from 3 columns to 4 columns (just inner view). Should be greater
/// than `pixelWidth2Columns`
const double pixelWidth3Columns = 1300;

/// trigger from 1 page reorder screen to 2 pages reorder screen (just inner
/// view). Should be greater than `pixelFixedDrawer`
const double twoSidedReorderScreen = 700;

const fallbackColorTheme = Colors.blue;

/// Responsive helper for columns
int responsiveNumCols(double displayWidth) {
  if (displayWidth < pixelWidth1Column) {
    return 1;
  } else if (displayWidth < pixelWidth2Columns) {
    return 2;
  } else if (displayWidth < pixelWidth3Columns) {
    return 3;
  }
  return 4;
}

/// Responsive aspect ratio
double responsiveChildAspectRatio(double width, int colNumber) =>
    width / (colNumber * 90);

bool isDrawerFixed(double displayWidth) => displayWidth > pixelFixedDrawer;
