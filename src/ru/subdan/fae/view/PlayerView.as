/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	import org.as3wavsound.WavSoundChannel;

	import ru.subdan.fae.model.vos.TrackVO;

	public class PlayerView extends Sprite
	{
		private var _channel:SoundChannel;
		private var _wavChannel:WavSoundChannel;
		private var _transform:SoundTransform = new SoundTransform(1);
		private var _trackVO:TrackVO;
		private var _isPlaying:Boolean;
		private var _endPos:Number;

		private var _lastDispatchedSecond:Number = 0;

		public function PlayerView()
		{

		}

		//----------------------------------------------------------------------
		//
		//  PUBLIC METHODS
		//
		//----------------------------------------------------------------------

		public function stopTrack():void
		{
			if (!_trackVO) return;

			if (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, onUpdate);

			_lastDispatchedSecond = 0;
			_isPlaying = false;

			if (_trackVO.soundFormat == TrackVO.FORMAT_MP3_SOUND)
			{
				if (_channel)
				{
					var pos:Number = _channel.position;
					ExternalInterface.call("fae_stopped", pos / 1000);
					_channel.stop();
					_channel.addEventListener(Event.SOUND_COMPLETE, onSC);
					_channel = null;
				}
			}
			else if (_trackVO.soundFormat == TrackVO.FORMAT_WAV_SOUND)
			{
				if (_wavChannel)
				{
					var posw:Number = _wavChannel.position;
					ExternalInterface.call("fae_stopped", posw  / 1000);
					_wavChannel.stop();
					_wavChannel.addEventListener(Event.SOUND_COMPLETE, onSC);
					_wavChannel = null;
				}
			}
		}

		public function playTrack(trackVO:TrackVO, startPos:Number, endPos:Number):void
		{
			if (trackVO.soundFormat == TrackVO.FORMAT_MP3_SOUND && !trackVO.mp3Sound) return;
			if (trackVO.soundFormat == TrackVO.FORMAT_WAV_SOUND && !trackVO.wavSound) return;

			_endPos = endPos;
			if (_isPlaying) stopTrack();
			_trackVO = trackVO;

			if (trackVO.soundFormat == TrackVO.FORMAT_MP3_SOUND)
			{
				_channel = _trackVO.mp3Sound.play(startPos * 1000);
				_channel.addEventListener(Event.SOUND_COMPLETE, onSC);
			}
			else if (trackVO.soundFormat == TrackVO.FORMAT_WAV_SOUND)
			{
				_wavChannel = _trackVO.wavSound.play(startPos * 1000);
				_wavChannel.addEventListener(Event.SOUND_COMPLETE, onSC);
			}

			addEventListener(Event.ENTER_FRAME, onUpdate);

			_isPlaying = true;
		}

		private function onUpdate(event:Event):void
		{
			if (_trackVO.soundFormat == TrackVO.FORMAT_MP3_SOUND && _channel)
			{
				if (Math.abs(_channel.position / 1000 - _lastDispatchedSecond) >= 0.25)
				{
					_lastDispatchedSecond = _channel.position / 1000;
					ExternalInterface.call("fae_playing", _trackVO.id, _channel.position / 1000);
				}
			}
			else if(_trackVO.soundFormat == TrackVO.FORMAT_WAV_SOUND && _wavChannel)
			{
				if (Math.abs(_wavChannel.position / 1000 - _lastDispatchedSecond) >= 0.25)
				{
					_lastDispatchedSecond = _wavChannel.position / 1000;
					ExternalInterface.call("fae_playing", _trackVO.id, _wavChannel.position / 1000);
				}
			}

			if (_trackVO.soundFormat == TrackVO.FORMAT_MP3_SOUND && _channel)
			{
				if (_channel.position >= _endPos * 1000)
				{
					ExternalInterface.call("fae_playing", _trackVO.id, _channel.position / 1000);
					stopTrack();
				}
			}
			else if (_trackVO.soundFormat == TrackVO.FORMAT_WAV_SOUND && _wavChannel)
			{
				if (_wavChannel.position >= _endPos * 1000)
				{
					ExternalInterface.call("fae_playing", _trackVO.id, _wavChannel.position / 1000);
					stopTrack();
				}
			}
		}

		private function onSC(event:Event):void
		{
			ExternalInterface.call("fae_playing", _trackVO.id, _trackVO.soundFormat == TrackVO.FORMAT_MP3_SOUND ? _trackVO.mp3Sound.length / 1000 : _trackVO.wavSound.length / 1000);
			stopTrack();
		}

		public function setVolume(volume:Number):void
		{
			_transform.volume = volume > 1 ? 1 : volume < 0 ? 0 : volume;
			SoundMixer.soundTransform = _transform;
		}
	}
}