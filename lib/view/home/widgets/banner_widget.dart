import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/controller/controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.controller,
    required this.data,
  });

  final Controller controller;
  final List<SongModel> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      height: Get.height / 4,
      width: Get.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: QueryArtworkWidget(
        controller: controller.onAudioQuery,
        id: data[controller.currentIndex.value].id,
        type: ArtworkType.AUDIO,
        quality: 100,
        nullArtworkWidget: Container(
          decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
              border: Border.all()),
          child: const Icon(
            Icons.music_note,
            color: Colors.white,
            size: 70,
          ),
        ),
      ),
    );
  }
}
