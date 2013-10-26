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
	import flash.events.StatusEvent;
	import flash.external.ExternalInterface;
	import flash.media.Microphone;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	import org.as3wavsound.WavSound;
	import org.bytearray.micrecorder.MicRecorder;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import org.bytearray.micrecorder.events.RecordingEvent;

	import ru.subdan.fae.controller.events.VolumesArrayEvent;
	import ru.subdan.fae.controller.events.WAVAvailEvent;
	import ru.subdan.utils.Utils;

	public class RecorderView extends Sprite
	{
		private var _recorder:MicRecorder;
		private var _recording:Boolean;

		private var _micAvail:Boolean;
		private var _id:String;

		public function RecorderView()
		{

		}

		public function startRecord(id:String):void
		{
			_id = id;

			if (!_recorder) init();

			if (!_micAvail)
			{
				ExternalInterface.call("fae_permissionRequired");
				setTimeout(Security.showSettings, 120, SecurityPanel.PRIVACY);
			}
			else
			{
				volumesArray = new <Number>[];
				_recorder.record();
				_recording = true;
			}
		}

		private function onStatus(event:StatusEvent):void
		{
			if (event.code == "Microphone.Unmuted")
			{
				_micAvail = true;
			}
			else if (event.code == "Microphone.Muted")
			{
				_micAvail = false;
			}
		}

		public function stopRecord():void
		{
			if (_recorder && _recording)
			{
				_recorder.stop();
				_recording = false;
			}
		}

		//----------------------------------------------------------------------
		//
		//  Private methods
		//
		//----------------------------------------------------------------------

		private function init(event:Event = null):void
		{
			_recorder = new MicRecorder(new WaveEncoder(), getMicrophone());
			_recorder.microphone.addEventListener(StatusEvent.STATUS, onStatus);
			_recorder.addEventListener(RecordingEvent.RECORDING, recordingHandler);
			_recorder.addEventListener(Event.COMPLETE, recordCompleteHandler);
		}

		private function free():void
		{
			_recorder.microphone.removeEventListener(StatusEvent.STATUS, onStatus);
			_recorder.removeEventListener(RecordingEvent.RECORDING, recordingHandler);
			_recorder.removeEventListener(Event.COMPLETE, recordCompleteHandler);
			_recorder.clearMemory();
			_recorder = null;
		}

		private function getMicrophone():Microphone
		{
			var mic:Microphone = Microphone.getMicrophone();

			if (!mic)
			{
				ExternalInterface.call("fae_recording", _id, "error");
			}

			_micAvail = !mic.muted;

			return mic;
		}

		//----------------------------------------------------------------------
		//
		//  Event handlers
		//
		//----------------------------------------------------------------------

		private var delta:int;

		private var volumesArray:Vector.<Number>;

		private function recordingHandler(event:RecordingEvent):void
		{
			if (getTimer() - delta > 250)
			{
				volumesArray.push(_recorder.microphone.activityLevel / 100);
				ExternalInterface.call("fae_recording", _id, "working", event.time, _recorder.microphone.activityLevel / 100);
				delta = getTimer();
			}
		}

		private function recordCompleteHandler(event:Event):void
		{
			var clonedBytes:ByteArray = Utils.cloneByteArray(_recorder.output);
			var wav:WavSound = new WavSound(clonedBytes);
			ExternalInterface.call("fae_recordingStopped", wav.length);
			dispatchEvent(new WAVAvailEvent(WAVAvailEvent.WAV_AVAILABLE, wav, clonedBytes));
			dispatchEvent(new VolumesArrayEvent(VolumesArrayEvent.VOLUMES_CAPTURED, volumesArray, _id));
			free();
		}
	}
}
