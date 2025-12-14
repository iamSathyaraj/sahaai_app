
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:audioplayers/audioplayers.dart';  
import 'package:sahaai/core/services/audio_services.dart';
// import '../../../core/services/audio_service.dart';  // Your AudioService

class VoiceRecorder extends StatefulWidget {
  final Function(String? path, Duration duration) onRecordingComplete;
  final String? initialPath;
  final int maxDuration;
 
  const VoiceRecorder({
    Key? key,
    required this.onRecordingComplete,
    this.initialPath,
    this.maxDuration = 60,
  }) : super(key: key);

  @override
  State<VoiceRecorder> createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder> 
    with SingleTickerProviderStateMixin {
  
  final AudioRecorder _recorder = AudioRecorder();  
  bool _isRecording = false;
  String? _path;
  Duration _duration = Duration.zero;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _timer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _path = widget.initialPath;

    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _recorder.dispose();
    AudioService.stop();
    super.dispose();
  }

  Future<bool> _requestPermissions() async {
    final micStatus = await Permission.microphone.request();
    return micStatus == PermissionStatus.granted;
  }

  Future<void> _startRecording() async {
    if (!await _requestPermissions()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission required')),
        );
      }
      return;
    }

    try {
      Directory tempDir = await getTemporaryDirectory();
      _path = '${tempDir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc, 
          bitRate: 128000
        ),
        path: _path!,  
      );

      if (mounted) setState(() {
        _isRecording = true;
        _duration = Duration.zero;
      });

      _pulseController.repeat(reverse: true);

      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (mounted) {
          setState(() => _duration += const Duration(milliseconds: 100));
          if (_duration.inSeconds >= widget.maxDuration) _stopRecording();
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recording failed: $e')),
        );
      }
    }
  }

  Future<void> _stopRecording() async {
    try {
      _timer?.cancel();
      _pulseController.stop();
      String? path = await _recorder.stop();

      if (mounted) {
        setState(() {
          _isRecording = false;
          _path = path;
        });
        widget.onRecordingComplete(path!, _duration);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Stop failed: $e')),
        );
      }
    }
  }

  Future<void> _playRecording() async {
    if (_path != null && File(_path!).existsSync()) {
      try {
        setState(() => _isPlaying = true);
        await AudioService.playVoiceNote(_path!);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Playback failed: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => _isPlaying = false);
      }
    }
  }

  Future<void> _deleteRecording() async {
    if (_path != null && File(_path!).existsSync()) {
      await File(_path!).delete();
    }
    if (mounted) {
      setState(() {
        _path = null;
        _duration = Duration.zero;
      });
      widget.onRecordingComplete(null, Duration.zero);
    }
  }

  String _formatDuration(Duration duration) {
    final remaining = widget.maxDuration - duration.inSeconds;
    return '${remaining}s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mic Button
          GestureDetector(
            onTap: _isRecording ? _stopRecording : _startRecording,
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) => Transform.scale(
                scale: _isRecording ? _pulseAnimation.value : 1.0,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _isRecording
                        ? const RadialGradient(colors: [Color(0xFFE57373), Color(0xFFEF5350)])
                        : const RadialGradient(colors: [Color(0xFF42A5F5), Color(0xFF1976D2)]),
                  ),
                  child: Icon(
                    _isRecording ? Icons.stop : Icons.mic,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          Text(
            _isRecording
                ? _formatDuration(_duration)
                : (_path != null ? '${_duration.inSeconds}s' : 'Tap to record'),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _isRecording ? Colors.red[600] : Colors.grey[600],
            ),
          ),
          
          const SizedBox(height: 12),
          
          if (_path != null && !_isRecording) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _isPlaying ? null : _playRecording,
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, 
                          color: Colors.green),
                  tooltip: 'Play',
                ),
                IconButton(
                  onPressed: _deleteRecording,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Delete',
                ),
              ],
            ),
            const Text(
              'Voice message recorded',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF757575),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
