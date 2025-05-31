import 'dart:math';

import 'package:flutter/material.dart';

class NeoColors {
  static const Color neonCyan = Color(0xFF7DF9FF);
  static const Color electricGreen = Color(0xFF2FFF2F);
  static const Color hotPink = Color(0xFFFF00F5);
  static const Color vividBlue = Color(0xFF3300FF);
  static const Color brightYellow = Color(0xFFFFFF00);
  static const Color lavaOrange = Color(0xFFFF4911);

  static const Color amberOrange = Color(0xFFFFAA00);
  static const Color skyBlue = Color(0xFF00AAFF);
  static const Color purpleMystic = Color(0xFFAA00FF);
  static const Color aquaMint = Color(0xFF00FFAA);
  static const Color magentaRose = Color(0xFFFF0055);
  static const Color limeZest = Color(0xFF55FF00);
  static const Color disabledGray = Color(0xFFB0B0B0);
  static const Color pigPink = Color(0xFFFFA6F6);

  static const Color iceBlue = Color(0xFFDAF5F0);
  static const Color sageGreen = Color(0xFFB5D2AD);
  static const Color butterYellow = Color(0xFFDFDF96);
  static const Color peachBeige = Color(0xFFF8D6B3);
  static const Color pinkBlush = Color(0xFFFCFFFF);
  static const Color lavenderGray = Color(0xFFE3DFF2);

  static const Color mintAqua = Color(0xFFA7DBD8);
  static const Color lightMint = Color(0xFFBAFCA2);
  static const Color paleGold = Color(0xFFFFDB58);
  static const Color coralPeach = Color(0xFFFFA07A);
  static const Color pinkCream = Color(0xFFFFC0CB);
  static const Color lightPurple = Color(0xFFC4A1FF);

  static const Color skyBlueLight = Color(0xFF87CEEB);
  static const Color springGreen = Color(0xFF90EE90);
  static const Color mustardYellow = Color(0xFFF4D738);
  static const Color salmonOrange = Color(0xFFFF7A5C);
  static const Color bubblegumPink = Color(0xFFFFB2EF);
  static const Color softPurple = Color(0xFFA388EE);

  static const Color brightCyan = Color(0xFF69D2E7);
  static const Color mossGreen = Color(0xFF7FBC8C);
  static const Color goldenBrown = Color(0xFFE3A018);
  static const Color tomatoRed = Color(0xFFFF6B6B);
  static const Color hotPink2 = Color(0xFFFF69B4);
  static const Color deepPurple = Color(0xFF9723C9);

  static const List<Color> brightValues = [
    brightCyan,
    mossGreen,
    goldenBrown,
    tomatoRed,
    hotPink2,
    neonCyan,
    amberOrange,
    electricGreen,
    vividBlue,
    magentaRose,
    limeZest,
  ];

  static const List<Color> neonValues = [
    neonCyan,
    electricGreen,
    hotPink,
    vividBlue,
    brightYellow,
    lavaOrange,
    amberOrange,
    skyBlue,
    purpleMystic,
    aquaMint,
    magentaRose,
    limeZest,
  ];

  static const List<Color> pastelValues = [
    iceBlue,
    sageGreen,
    butterYellow,
    peachBeige,
    pinkBlush,
    lavenderGray,
    mintAqua,
    lightMint,
    paleGold,
    coralPeach,
    pinkCream,
    lightPurple,
    skyBlueLight,
    springGreen,
    mustardYellow,
    salmonOrange,
    bubblegumPink,
    softPurple,
    brightCyan,
    mossGreen,
    goldenBrown,
    tomatoRed,
    hotPink2,
    deepPurple,
  ];

  static Color randomPastel() {
    final random = Random();
    return pastelValues[random.nextInt(pastelValues.length)];
  }

  static Color randomRegisterColors() {
    final random = Random();
    final neonValues = [
      neonCyan,
      electricGreen,
      hotPink,
      vividBlue,
      brightYellow,
      lavaOrange,
      amberOrange,
      skyBlue,
      aquaMint,
      magentaRose,
      limeZest,
      iceBlue,
      skyBlueLight,
      lightMint,
      mossGreen,
      pinkCream,
      coralPeach,
    ];
    return neonValues[random.nextInt(neonValues.length)];
  }

  static Color randomBright() {
    final random = Random();
    return brightValues[random.nextInt(brightValues.length)];
  }
}
