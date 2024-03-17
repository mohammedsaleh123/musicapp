import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicapp/core/app_colors.dart';
import 'package:musicapp/view/listsongs/list_songs_view.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestStoragePermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: ListSongsView(),
      ),
    );
  }
}

Future<void> requestStoragePermission() async {
  final OnAudioQuery onAudioQuery = OnAudioQuery();
  final permisionHandler = await Permission.storage.request();
  final permision = await onAudioQuery.checkAndRequest(retryRequest: true);
  if (permision && permisionHandler.isGranted) {
  } else {
    Get.snackbar(
        backgroundColor: lightC,
        'title',
        'message',
        icon: IconButton(
          onPressed: () {
            requestStoragePermission();
          },
          icon: const Icon(Icons.perm_device_info_sharp),
        ));
  }
}
