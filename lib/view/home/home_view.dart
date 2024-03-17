import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicapp/controller/controller.dart';
import 'package:musicapp/core/app_colors.dart';
import 'package:musicapp/core/extension/center_extension.dart';
import 'package:musicapp/core/extension/padding_extension.dart';
import 'package:musicapp/core/widgets/custom_text.dart';
import 'package:musicapp/view/home/widgets/home_body.dart';
import 'package:musicapp/view/listsongs/list_songs_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key, required this.index, required this.data});
  Controller controller = Get.find();
  final int index;
  final SongModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, darkC],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.off(() => ListSongsView());
                      controller.audioPlayer.stop();
                    },
                    child: const Icon(Icons.arrow_back, color: darkC)
                        .padding(12.w, 0),
                  ),
                  const Spacer(flex: 2),
                  CustomText(
                    text: 'My Music',
                    color: lightC,
                    fontSize: 20.sp,
                  ).center(),
                  const Spacer(flex: 3),
                ],
              ).padding(0, 8.h),
              FutureBuilder<List<SongModel>>(
                future: controller.onAudioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  return HomeBody(
                    controller: controller,
                    snapshot: snapshot,
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
