// ignore_for_file: file_names
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';

class AudioController extends GetxController{
  static AudioController get to => Get.find<AudioController>();

  final slashAtkBGM1 = AssetsAudioPlayer.withId('slashAtkBGM');
  final critSlashAtkBGM1 = AssetsAudioPlayer.withId('criticalSlashAtkBGM');
  final lobbyBGM = AssetsAudioPlayer.withId('lobbyBGM');

  playNormalAtkBGM() async {
    await slashAtkBGM1.open(
      Audio('assets/audio/hit-soundEffect.mp3'),
      autoStart: true,
      showNotification: false,
      respectSilentMode: false,
      volume: 1.0,
    );
  }

  playCriticalAtkBGM() async {
    await critSlashAtkBGM1.open(
      Audio('assets/audio/criticalHit-soundEffect.mp3'),
      autoStart: true,
      showNotification: false,
      respectSilentMode: false,
      volume: 1.0,
    );
  }

  playLobbyBgm() async {
    await lobbyBGM.open(
      Audio('assets/audio/lobby-BGM.mp3'),
      loopMode: LoopMode.single,
      autoStart: true,
      showNotification: false,
      respectSilentMode: false,
      playInBackground: PlayInBackground.disabledRestoreOnForeground,
      volume: 0.75,
    );
  }
}