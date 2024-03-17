import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/controller/controller.dart';
import 'package:musicapp/core/app_colors.dart';

class PlayAnimationWidget extends StatelessWidget {
  const PlayAnimationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/play_animation.png',
              height: 250, width: 250),
          SizedBox(
            height: 240,
            width: 240,
            child: controller.isPlaying
                ? CircularProgressIndicator(
                    value: 90,
                    strokeWidth: 9,
                    color: offLightC.withOpacity(0.1),
                  )
                : Container(),
          ),
          SizedBox(
            height: 150,
            width: 150,
            child: controller.isPlaying
                ? CircularProgressIndicator(
                    strokeWidth: 5,
                    color: offLightC.withOpacity(0.1),
                  )
                : Container(),
          ),
          SizedBox(
            child: controller.isPlaying
                ? CircularProgressIndicator(
                    color: Colors.red.shade700,
                  )
                : Container(),
          ),
        ],
      );
    });
  }
}
