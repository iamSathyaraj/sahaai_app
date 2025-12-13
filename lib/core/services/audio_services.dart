
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playVoiceNote(String filePath) async {
    try {
      await _audioPlayer.play(DeviceFileSource(filePath));
    } catch (e) {   
      throw Exception('Audio playback failed: $e');
    }
  }

  static Future<void> stop() async {
    await _audioPlayer.stop();
  }

  static void dispose() {
    _audioPlayer.dispose();
  }
}
