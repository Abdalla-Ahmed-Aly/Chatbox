import 'dart:async';

import 'package:chatbox/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class Playrecordsender extends StatefulWidget {
  final String audioPath;
  const Playrecordsender({required this.audioPath});

  @override
  State<Playrecordsender> createState() => _PlayrecordsenderState();
}

class _PlayrecordsenderState extends State<Playrecordsender> {
  static _PlayrecordsenderState? _currentPlayer;

  late final AudioPlayer _player;
  late final PlayerController _waveController;

  bool _isPlaying = false;
  bool _isPrepared = false;
  bool _hasError = false;

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  StreamSubscription<Duration>? _durationSub;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<void>? _completeSub;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _player = AudioPlayer();
    _waveController = PlayerController();

    _durationSub = _player.onDurationChanged.listen((duration) {
      if (!mounted) return;
      setState(() => _duration = duration ?? Duration.zero);
    });

    _positionSub = _player.onPositionChanged.listen((position) {
      if (!mounted) return;
      setState(() => _position = position);
    });

    _completeSub = _player.onPlayerComplete.listen((_) async {
      await _handlePlaybackComplete();
    });

    await _preparePlayer();
  }

  Future<void> _preparePlayer() async {
    try {
      await _waveController.preparePlayer(path: widget.audioPath);
      if (!mounted) return;
      setState(() {
        _isPrepared = true;
        _hasError = false;
        _position = Duration.zero;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _isPrepared = false;
      });
      debugPrint("Player preparation error: $e");
    }
  }

  Future<void> _handlePlaybackComplete() async {
    debugPrint("Audio playback completed");

    if (!mounted) return;

    setState(() {
      _isPlaying = false;
      _position = Duration.zero;
    });

    await _waveController.pausePlayer();
    await _waveController.seekTo(0);
    await _preparePlayer();

    if (mounted) setState(() {});
  }

  Future<void> _togglePlay() async {
    if (!_isPrepared || _hasError) return;

    if (_isPlaying) {
      await _pausePlayer();
    } else {
      await _startPlayer();
    }
  }

  Future<void> _startPlayer() async {
    if (_currentPlayer != null && _currentPlayer != this) {
      await _currentPlayer!._pausePlayer();
    }
    _currentPlayer = this;

    try {
      await _waveController.seekTo(0);
      await _player.play(DeviceFileSource(widget.audioPath));
      await _waveController.startPlayer();

      if (mounted) setState(() => _isPlaying = true);
    } catch (e) {
      debugPrint("Playback error: $e");
      if (mounted) setState(() => _hasError = true);
    }
  }

  Future<void> _pausePlayer() async {
    try {
      await _player.pause();
      await _waveController.pausePlayer();
      if (mounted) setState(() => _isPlaying = false);
    } catch (e) {
      debugPrint("Pause error: $e");
    }
  }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    if (_currentPlayer == this) _currentPlayer = null;

    _durationSub?.cancel();
    _positionSub?.cancel();
    _completeSub?.cancel();

    _player.dispose();
    _waveController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Positioned(
      child: Row(
        children: [
          InkWell(
            onTap: _hasError ? null : _togglePlay,
            child: CircleAvatar(
              backgroundColor: _hasError ? Colors.red : AppTheme.whiteGreen,
              radius: 18,
              child: Icon(
                _hasError
                    ? Icons.error
                    : (_isPlaying ? Icons.pause : Icons.play_arrow),
                color: AppTheme.lightGreen,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: _isPrepared
                ? AudioFileWaveforms(
                    size: Size(MediaQuery.of(context).size.width, 40),
                    playerController: _waveController,
                    waveformType: WaveformType.fitWidth,
                    enableSeekGesture: true,
                    playerWaveStyle: PlayerWaveStyle(
                      fixedWaveColor: Colors.grey.shade400,
                      liveWaveColor: _isPlaying
                          ? AppTheme.whiteGreen
                          : Colors.grey.shade400,
                      waveThickness: 1.5,
                      spacing: 3,
                    ),
                  )
                : _hasError
                ? const Text(
                    "Failed to load audio",
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox(
                    height: 40,
                    child: Center(child: CircularProgressIndicator()),
                  ),
          ),
          const SizedBox(width: 8),

          Text(
            _isPlaying ? _formatTime(_position) : _formatTime(_duration),
            style: textTheme.bodyMedium!.copyWith(
              color: _hasError ? Colors.red : AppTheme.whiteGreen,
            ),
          ),
        ],
      ),
    );
  }
}
