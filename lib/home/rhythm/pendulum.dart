import 'package:flutter/material.dart';
import 'package:metronome/home/bpm/bpm_model.dart';
import 'package:metronome/property/color_settings.dart';
import 'package:metronome/property/hex.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'rhythm_model.dart';

class Pendulum extends StatefulWidget {
  const Pendulum({Key? key, required this.model}) : super(key: key);

  final RhythmModel model;

  @override
  _PendulumState createState() => _PendulumState();
}

class _PendulumState extends State<Pendulum>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _alignmentAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: widget.model.pendulumTempoDuration),
      vsync: this,
    );
    
    _alignmentAnimation = Tween<Alignment>(
      begin: Alignment.bottomRight,
      end: Alignment.bottomLeft,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateAnimation() {
    if (widget.model.run) {
      _animationController.duration = 
          Duration(milliseconds: widget.model.pendulumTempoDuration);
      
      if (widget.model.alignment == Alignment.bottomLeft) {
        _alignmentAnimation = Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        _animationController.forward(from: 0);
      } else {
        _alignmentAnimation = Tween<Alignment>(
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        _animationController.forward(from: 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RhythmModel>(
      builder: (context, model, child) {
        // アニメーションの更新が必要な場合のみ実行
        if (model.shouldUpdatePendulum) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _updateAnimation();
            model.resetPendulumUpdate();
          });
        }

        return Column(
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal! * 90,
              height: SizeConfig.blockSizeVertical! * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 左側のジャストタイミングとして許容する範囲
                  Container(
                    width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth +
                        model.safeWidth,
                    height: SizeConfig.blockSizeVertical! * 1,
                    // ! ジャストのエリア可視化
                    color: context.read<BpmModel>().isJustZone &&
                            !context.read<BpmModel>().isPendulum
                        ? Colors.green
                        : HexColor('#f0f0f0'),
                    key: model.leftGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
                  ),
                  // 中間線
                  Container(
                    width: SizeConfig.blockSizeHorizontal! * 1,
                    height: SizeConfig.blockSizeVertical! * 1,
                    color: context.read<BpmModel>().isPendulum
                        ? Colors.white
                        : Colors.grey[300],
                  ),
                  // 右側のジャストタイミングとして許容する範囲
                  Container(
                    width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth +
                        model.safeWidth,
                    height: SizeConfig.blockSizeVertical! * 1,
                    // ! ジャストのエリア可視化
                    color: context.read<BpmModel>().isJustZone &&
                            !context.read<BpmModel>().isPendulum
                        ? Colors.green
                        : HexColor('#f0f0f0'),
                    key: model.rightGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
                  ),
                ],
              ),
            ),
            // 振り子
            Container(
              width: SizeConfig.blockSizeHorizontal! * 90,
              height: SizeConfig.blockSizeVertical! * 3,
              color: context.read<BpmModel>().isPendulum
                  ? Colors.white
                  : Colors.grey[300],
              child: AnimatedBuilder(
                animation: _alignmentAnimation,
                builder: (context, child) {
                  return Align(
                    alignment: _alignmentAnimation.value,
                    child: Container(
                      // 振り子本体
                      width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth,
                      height: SizeConfig.blockSizeVertical! * 4,
                      color: context.read<BpmModel>().isPendulum
                          ? Colors.white
                          : context.read<ColorSettings>().primaryColor,
                      key: model.pendulumGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
                    ),
                  );
                },
              ),
            ),

            // 中間線
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.blockSizeHorizontal! * 1,
                  height: SizeConfig.blockSizeVertical! * 1,
                  color: context.read<BpmModel>().isPendulum
                      ? Colors.white
                      : Colors.grey[300],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
