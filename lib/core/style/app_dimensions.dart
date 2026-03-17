import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/extensions.dart';

/// Constant pixel values (used before applying `.ph`, `.pw`, etc.)
class Sizes {
  static const double p2 = 2.0;
  static const double p4 = 4.0;
  static const double p6 = 6.0;
  static const double p8 = 8.0;
  static const double p10 = 10.0;
  static const double p12 = 12.0;
  static const double p16 = 16.0;
  static const double p20 = 20.0;
  static const double p22 = 22.0;
  static const double p24 = 24.0;
  static const double p26 = 26.0;
  static const double p29 = 29.0;
  static const double p30 = 30.0;
  static const double p32 = 32.0;
  static const double p40 = 40.0;
  static const double p46 = 46.0;
  static const double p48 = 48.0;
  static const double p54 = 54.0;
  static const double p59 = 59.0;
  static const double p60 = 60.0;
  static const double p64 = 64.0;
  static const double p72 = 72.0;
  static const double p92 = 92.0;
  static const double p120 = 120.0;
  static const double p154 = 154.0;
  static const double p160 = 160.0;
  static const double p200 = 200.0;
  static const double p206 = 206.0;
  static const double p214 = 214.0;
}

/// Responsive gaps using `.ph` and `.pw` extensions
class ResponsiveGaps {
  static SizedBox gapW(double width) => SizedBox(width: width.pw);

  static SizedBox gapH(double height) => SizedBox(height: height.ph);

  static final w4 = gapW(Sizes.p4);
  static final w8 = gapW(Sizes.p8);
  static final w12 = gapW(Sizes.p12);
  static final w16 = gapW(Sizes.p16);
  static final w20 = gapW(Sizes.p20);
  static final w24 = gapW(Sizes.p24);
  static final w26 = gapW(Sizes.p26);
  static final w32 = gapW(Sizes.p32);
  static final w40 = gapW(Sizes.p40);
  static final w46 = gapW(Sizes.p46);
  static final w48 = gapW(Sizes.p48);
  static final w64 = gapW(Sizes.p64);

  static final h4 = gapH(Sizes.p4);
  static final h8 = gapH(Sizes.p8);
  static final h12 = gapH(Sizes.p12);
  static final h16 = gapH(Sizes.p16);
  static final h20 = gapH(Sizes.p20);
  static final h24 = gapH(Sizes.p24);
  static final h26 = gapH(Sizes.p26);
  static final h32 = gapH(Sizes.p32);
  static final h40 = gapH(Sizes.p40);
  static final h46 = gapH(Sizes.p46);
  static final h48 = gapH(Sizes.p48);
  static final h54 = gapH(Sizes.p54);
  static final h59 = gapH(Sizes.p59);
  static final h64 = gapH(Sizes.p64);
  static final h120 = gapH(Sizes.p120);
  static final h200 = gapH(Sizes.p200);
}

/// Constant gap widths
const gapW4 = SizedBox(width: Sizes.p4);
const gapW8 = SizedBox(width: Sizes.p8);
const gapW10 = SizedBox(width: Sizes.p10);
const gapW12 = SizedBox(width: Sizes.p12);
const gapW16 = SizedBox(width: Sizes.p16);
const gapW20 = SizedBox(width: Sizes.p20);
const gapW24 = SizedBox(width: Sizes.p24);
const gapW26 = SizedBox(width: Sizes.p26);
const gapW32 = SizedBox(width: Sizes.p32);
const gapW40 = SizedBox(width: Sizes.p40);
const gapW46 = SizedBox(width: Sizes.p46);
const gapW48 = SizedBox(width: Sizes.p48);
const gapW64 = SizedBox(width: Sizes.p64);
const gapW120 = SizedBox(width: Sizes.p120);

/// Constant gap heights
const gapH2 = SizedBox(height: Sizes.p2);
const gapH4 = SizedBox(height: Sizes.p4);
const gapH6 = SizedBox(height: Sizes.p6);
const gapH8 = SizedBox(height: Sizes.p8);
const gapH10 = SizedBox(height: Sizes.p10);
const gapH12 = SizedBox(height: Sizes.p12);
const gapH16 = SizedBox(height: Sizes.p16);
const gapH20 = SizedBox(height: Sizes.p20);
const gapH22 = SizedBox(height: Sizes.p22);
const gapH24 = SizedBox(height: Sizes.p24);
const gapH26 = SizedBox(height: Sizes.p26);
const gapH29 = SizedBox(height: Sizes.p29);
const gapH30 = SizedBox(height: Sizes.p30);
const gapH32 = SizedBox(height: Sizes.p32);
const gapH40 = SizedBox(height: Sizes.p40);
const gapH46 = SizedBox(height: Sizes.p46);
const gapH48 = SizedBox(height: Sizes.p48);
const gapH54 = SizedBox(height: Sizes.p54);
const gapH60 = SizedBox(height: Sizes.p60);
const gapH64 = SizedBox(height: Sizes.p64);
const gapH92 = SizedBox(height: Sizes.p92);
const gapH120 = SizedBox(height: Sizes.p120);
const gapH160 = SizedBox(height: Sizes.p160);
const gapH200 = SizedBox(height: Sizes.p200);
const gapH206 = SizedBox(height: Sizes.p206);
const gapH214 = SizedBox(height: Sizes.p214);

class Paddings {
  static const EdgeInsets paddingAllXS = EdgeInsets.all(Sizes.p4);
  static const EdgeInsets paddingAllS = EdgeInsets.all(Sizes.p12);
  static const EdgeInsets paddingAllM = EdgeInsets.all(Sizes.p16);
  static const EdgeInsets paddingOnlyRightM = EdgeInsets.only(right: Sizes.p16);
  static const EdgeInsets paddingOnlyTopXS = EdgeInsets.only(top: Sizes.p4);

  static const EdgeInsets paddingHorizontalM = EdgeInsets.symmetric(
    horizontal: Sizes.p16,
  );
  static const EdgeInsets paddingHorizontalL = EdgeInsets.symmetric(
    horizontal: Sizes.p20,
  );
}
