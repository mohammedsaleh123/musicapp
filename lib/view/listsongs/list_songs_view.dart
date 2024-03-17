import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicapp/controller/controller.dart';
import 'package:musicapp/core/app_colors.dart';
import 'package:musicapp/core/extension/padding_extension.dart';
import 'package:musicapp/core/widgets/custom_text.dart';
import 'package:musicapp/view/home/home_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class ListSongsView extends StatelessWidget {
  ListSongsView({super.key});
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
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
                  const Icon(Icons.music_note, color: darkC),
                  CustomText(
                    text: 'My Music',
                    color: lightC,
                    fontSize: 20.sp,
                  ),
                  const Icon(Icons.music_note, color: darkC),
                ],
              ).padding(0, 8.h),
              GetBuilder<Controller>(builder: (controller) {
                return FutureBuilder<List<SongModel>>(
                  future: controller.onAudioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: CustomText(
                              text: snapshot.data![index].displayNameWOExt,
                              color: lightC,
                            ),
                            subtitle: CustomText(
                              text: snapshot.data![index].artist!,
                              color: offLightC,
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              artworkHeight: 50,
                              artworkWidth: 50,
                              nullArtworkWidget: const Icon(
                                Icons.music_note,
                                color: lightC,
                              ),
                            ),
                            onTap: () {
                              controller.changePlayState();
                              controller.playSong(
                                  snapshot.data![controller.currentIndex.value]
                                      .uri!,
                                  index);
                              Get.to(() => HomeView(
                                  data: snapshot.data![index], index: index));
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
