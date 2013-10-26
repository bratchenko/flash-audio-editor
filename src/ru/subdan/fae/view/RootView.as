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
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.utils.getTimer;

	import ru.subdan.fae.controller.events.FromJSEvent;

	public class RootView extends Sprite
	{
		private var _playerView:PlayerView;
		private var _recorderView:RecorderView;

		public function RootView()
		{
			_playerView = new PlayerView();
			addChild(_playerView);

			_recorderView = new RecorderView();
			addChild(_recorderView);

			ExternalInterface.addCallback("createEmptyTrack", createEmptyTrack);
			ExternalInterface.addCallback("createTrackFromUrl", createTrackFromURL);
			ExternalInterface.addCallback("deleteTrack", deleteTrack);

			ExternalInterface.addCallback("play", playTrack);
			ExternalInterface.addCallback("stop", stopTrack);
			ExternalInterface.addCallback("setVolume", setVolume);

			ExternalInterface.addCallback("record", record);
			ExternalInterface.addCallback("stopRecording", stopRecording);

			ExternalInterface.addCallback("generateWaveform", generateWaveform);

			ExternalInterface.addCallback("upload", upload);
			ExternalInterface.addCallback("stopUploading", stopUploading);

			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(event:Event = null):void
		{
			if (hasEventListener(Event.ADDED_TO_STAGE))
				removeEventListener(Event.ADDED_TO_STAGE, init);

			stage.addEventListener(MouseEvent.CLICK, onClickMouse);
		}

		private function setVolume(volume:Number):void
		{
			dispatchEvent(new FromJSEvent(FromJSEvent.SET_VOLUME, {volume:volume}));
		}

		private function upload(id:String, url:String, name:String, data:String):void
		{
			dispatchEvent(new FromJSEvent(FromJSEvent.UPLOAD, {id: id, url:url, name:name, data:data}));
		}

		private function stopUploading(id:String):void
		{
			dispatchEvent(new FromJSEvent(FromJSEvent.STOP_UPLOADING, {id: id}));
		}

		private function generateWaveform(id:String):void
		{
			dispatchEvent(new FromJSEvent(FromJSEvent.GENERATE_WAVEFORM, {id: id}));
		}

		private function record(id:String):void
		{
			dispatchEvent(new FromJSEvent(FromJSEvent.RECORD, {id: id}));
		}

		private function stopRecording():void
		{
			dispatchEvent(new FromJSEvent(FromJSEvent.STOP_RECORDING, {}));
		}

		private function createEmptyTrack():Number
		{
			var timestamp:Number = getTimestamp();
			dispatchEvent(new FromJSEvent(FromJSEvent.CREATE_EMPTY_TRACK, {id: timestamp}));
			return timestamp;
		}

		private function createTrackFromURL(url:String):Number
		{
			var timestamp:Number = getTimestamp();
			dispatchEvent(new FromJSEvent(FromJSEvent.CREATE_TRACK_FROM_URL, {id: timestamp, url: url}));
			return timestamp;
		}

		private function deleteTrack(id:String):void
		{
			dispatchEvent(new FromJSEvent(FromJSEvent.DELETE_TRACK, {id: id}));
		}

		private function playTrack(trackId:String, startSecond:Number,
		                           endSecond:Number):void
		{
			dispatchEvent(new FromJSEvent(FromJSEvent.PLAY_TRACK, {id: trackId, startSecond: startSecond, endSecond: endSecond}));
		}

		private function stopTrack():void
		{
			dispatchEvent(new FromJSEvent(FromJSEvent.STOP_TRACK, {}));
		}

		private static function getTimestamp():Number
		{
			return Number(String(new Date().time) + String(int(Math.random() * 1000)));
		}

		private function onClickMouse(event:MouseEvent):void
		{
			dispatchEvent(new FromJSEvent(FromJSEvent.CREATE_TRACK_FROM_LOCAL_FILE, {id: getTimestamp()}));
		}
	}
}
