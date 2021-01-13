import 'package:audioplayers/audioplayers.dart';

class Audio{

	factory Audio() => _getInstance();

	static Audio get instance => _getInstance();

	static Audio _instance;

	static AudioPlayer _audioPlayer;

	Audio._internal(){
		_audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
	}

	static Audio _getInstance(){
		if(_instance == null){
			_instance = Audio._internal();
		}
		return _instance;
	}

	void play(String url) async{
		await _audioPlayer.play(url,
			isLocal: false,
			position: Duration()
		);
	}

	void loop(String url) async{
		if(_audioPlayer.state != null && _audioPlayer.state != AudioPlayerState.STOPPED){
			stop();
		}
		await _audioPlayer.setReleaseMode(ReleaseMode.LOOP);
		play(url);
	}

	void pause() async{
		await _audioPlayer.pause();
	}

	void resume() async{
		await _audioPlayer.resume();
	}

	void stop() async{
		await _audioPlayer.stop();
	}

	void dispose() async{
		if(_audioPlayer.state != AudioPlayerState.STOPPED){
			_audioPlayer.state = AudioPlayerState.STOPPED;
		}
		await _audioPlayer.stop();
		await _audioPlayer.release();
		await _audioPlayer.dispose();
	}
}