import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/controller/controller.dart';
import 'package:musicapp/core/app_colors.dart';
import 'package:musicapp/core/widgets/custom_text.dart';
import 'package:musicapp/view/home/widgets/banner_widget.dart';
import 'package:musicapp/view/home/widgets/play_animation_widget.dart';
import 'package:musicapp/view/home/widgets/play_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.controller,
    required this.snapshot,
    required this.index,
  });

  final Controller controller;
  final int index;
  final AsyncSnapshot<List<SongModel>> snapshot;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      return Expanded(
        child: Column(
          children: [
            BannerWidget(controller: controller, data: snapshot.data!),
            CustomText(
              text: snapshot.data![controller.currentIndex.value].title,
              color: lightC,
            ),
            CustomText(
              text:
                  'Artist: ${snapshot.data![controller.currentIndex.value].artist}',
              color: lightC,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                    text: controller.position.value,
                    color: lightC,
                  ),
                  Slider(
                      min: const Duration(seconds: 0).inSeconds.toDouble(),
                      max: controller.max.toDouble(),
                      value: controller.value.value,
                      onChanged: (newValue) {
                        controller.seekToValue(newValue.seconds);
                        newValue = newValue;
                      }),
                  CustomText(
                    text: controller.duration.value,
                    color: lightC,
                  ),
                ],
              ),
            ),
            PlayWidget(
                data: snapshot.data!, index: controller.currentIndex.value),
            const PlayAnimationWidget(),
          ],
        ),
      );
    });
  }
}
