import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/controller/controller.dart';
import 'package:musicapp/core/app_colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayWidget extends StatelessWidget {
  const PlayWidget({
    super.key,
    required this.data,
    required this.index,
  });

  final List<SongModel> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      return Container(
        width: Get.width,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: offLightC,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 50,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: lightC,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.skip_previous,
                  size: 50,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.changePlayState();

                controller.playSong(data[controller.currentIndex.value].uri!,
                    controller.currentIndex.value);
              },
              child: Container(
                width: 50,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: controller.isPlaying
                          ? [
                              lightC.withOpacity(0.2),
                              lightC.withOpacity(0.8),
                              lightC.withOpacity(0.8),
                              lightC.withOpacity(0.2),
                            ]
                          : [lightC, lightC]),
                  boxShadow: controller.isPlaying
                      ? []
                      : [
                          BoxShadow(
                            offset: const Offset(4, 4),
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                          ),
                        ],
                  color: lightC,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  controller.isPlaying ? Icons.pause : Icons.play_arrow,
                  //color: lightC,
                  size: 50,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.updateDuration();
                controller.playSong(
                    data[controller.currentIndex.value + 1].uri!,
                    controller.currentIndex.value + 1);
              },
              child: Container(
                width: 50,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: lightC,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.skip_next,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
