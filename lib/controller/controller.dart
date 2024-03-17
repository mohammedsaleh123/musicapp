import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Controller extends GetxController {
  @override
  void onInit() {
    //updateDuration();
    super.onInit();
  }

  final audioPlayer = AudioPlayer();
  final OnAudioQuery onAudioQuery = OnAudioQuery();
  List<SongModel> allSongs = [];
  bool isPlaying = false;
  var position = ''.obs;
  var duration = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;
  var currentIndex = 0.obs;

  updateDuration() {
    audioPlayer.positionStream.listen((event) {
      position.value = event.toString().split('.')[0];
      value.value = event.inSeconds.toDouble();
    });
    audioPlayer.durationStream.listen((event) {
      duration.value = event!.toString().split('.')[0];
      max.value = event.inSeconds.toDouble();
      update();
    });
  }

  seekToValue(newValue) {
    audioPlayer.seek(newValue);
    update();
  }

  playSong(String uri, index) async {
    currentIndex.value = index;
    await audioPlayer.setAudioSource(
      preload: false,
      AudioSource.uri(
        Uri.parse(uri),
      ),
    );
    isPlaying == true ? audioPlayer.play() : audioPlayer.pause();
    updateDuration();
    update();
  }

  changePlayState() {
    isPlaying = !isPlaying;
    update();
  }
}
