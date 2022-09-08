import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:space_impact/views/screens/game.dart';

class AudioService extends Component with HasGameRef<SpaceImpact> {
  @override
  Future<void>? onLoad() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'music/background.m4a',
      'sfx/laser1.mp3',
      'sfx/laser3.mp3',
      'sfx/laser4.mp3'
    ]);
    super.onLoad();
  }

  void playBackground() {
    FlameAudio.bgm.play("music/background.m4a");
  }

  void playSfx(String name) {
    FlameAudio.play(name);
  }

  void pauseBackground() {
    FlameAudio.bgm.pause();
  }

  void resumeBackground() {
    FlameAudio.bgm.resume();
  }
}
