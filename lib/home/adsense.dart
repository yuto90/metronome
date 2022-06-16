import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:metronome/home/home_model.dart';
import '../size_config.dart';

class Adsense extends StatelessWidget {
  const Adsense({Key? key, required this.model}) : super(key: key);

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: model.homeProperty.smooth(),
      width: double.infinity,
      height: SizeConfig.blockSizeVertical! * 10,
      child: AdWidget(ad: model.myBanner),
    );
  }
}
