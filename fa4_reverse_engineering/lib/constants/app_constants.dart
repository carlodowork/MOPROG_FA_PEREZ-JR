import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFFFDAD4);
  static const primary = Color(0xFF73332B);
  static const onPrimary  =  Colors.white;
  static const text = Color(0xFF442925);
  static  const outline = Color(0xFF857370);
  static const menuSurface = Color(0xFFFFF8F7);
  static const menuHighlight = Color(0xFFC4BDC4);
  static const defaultParameterColor = Color(0xFFFFFEF9);
}

class AppSpacing {
  static const double xs = 4;
  static const double  sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double fieldGap = 24;
  static const double formSidePadding = 48;
}

class AppSizes {
  static const double swatch = 30;
  static const double wheel = 230;
  static const double wheelSelector = 24;
  static const double buttonRadius = 24;
  static const double fieldRadius  =  8;
}

class AppLimits {
  static const int maxTextLength = 50;
  static const int minQuantity = 1;
  static const int defaultQuantity = 1;
  static const String defaultPrice = '1.00';
}

class AppStrings {
  static const appTitle = 'Supplies';
  static const homeTitle = 'Supplies';
  static const addParameterTitle = 'Add a new parameter';
  static const addSupplyTitle = 'Add a new supply'; 

  static const parameterName  = 'Parameter Name';
  static const parameterClass = 'Parameter Class';
  static const reset = 'Reset';
  static const addParameter = 'Add Parameter';

  static const itemName = 'Item Name';
  static const itemQuantity = 'Item Quantity';
  static const unitPrice = 'Unit Price';
  static const parameterPicker = 'Parameter';
  static const addSupply = 'Add Supply';

  static const emptySupplies = 'No supplies yet.\nTap "Add Supply" to create one.';

  static const errNameRequired = 'Parameter name is required';
  static const errClassRequired = 'Parameter class is required';
  static const errNameExists = 'A parameter with this name already exists';
  static const errItemRequired = 'Item name is required';
  static const errPriceInvalid = 'Enter a valid price greater than 0';
  static const errParameterRequired = 'Please select a parameter';

  static const parameterAdded = 'Parameter added';
  static const supplyAdded = 'Supply added';
}
