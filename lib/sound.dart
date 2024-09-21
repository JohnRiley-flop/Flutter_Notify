import 'package:audioplayers/audioplayers.dart';

var audioPlayer = AudioPlayer();

class SoundPlayer {
  static List<String> sFXFold = ["button_click_1.mp3"];
  static List<String> sFXList = [];
  static AudioCache cachecache = AudioCache(prefix: "assets/sounds/");

  init() async {
    //for every file in assets/sounds
    for (var item in sFXFold) {
      final link = await cachecache.load(item);
      sFXList.add(link.path);
    }
  }

  play(int soundNum) async {
    audioPlayer.play(sFXList[soundNum - 1], isLocal: true);
  }
}
