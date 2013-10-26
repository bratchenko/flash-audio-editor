/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.helpers
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;

	import fr.kikko.lab.ShineMP3Encoder;

	public class Converter extends EventDispatcher
	{
		private var _mp3Encoder:ShineMP3Encoder;
		private var _mp3Bytes:ByteArray;

		public function convertToMP3(wavBA:ByteArray):void
		{
			if (_mp3Encoder)
			{
				removeEncoderListeners();
				_mp3Encoder = null;
			}

			_mp3Encoder = new ShineMP3Encoder(wavBA);
			addEncoderListeners();

			_mp3Encoder.start();
		}

		public function free():void
		{
			if (_mp3Encoder && _mp3Encoder.mp3Data)
				_mp3Encoder.mp3Data.clear();
		}

		//----------------------------------------------------------------------
		//
		//  Private methods
		//
		//----------------------------------------------------------------------

		private function removeEncoderListeners():void
		{
			_mp3Encoder.removeEventListener(Event.COMPLETE, mp3EncodeCompleteHandler);
			_mp3Encoder.removeEventListener(ProgressEvent.PROGRESS, mp3EncodeProgressHandler);
		}

		private function addEncoderListeners():void
		{
			_mp3Encoder.addEventListener(ErrorEvent.ERROR, mp3EncodeError);
			_mp3Encoder.addEventListener(Event.COMPLETE, mp3EncodeCompleteHandler);
			_mp3Encoder.addEventListener(ProgressEvent.PROGRESS, mp3EncodeProgressHandler);
		}

		private function mp3EncodeError(event:ErrorEvent):void
		{
			dispatchEvent(event);
		}

		//----------------------------------------------------------------------
		//
		//  Event handlers
		//
		//----------------------------------------------------------------------

		private function mp3EncodeProgressHandler(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}

		private function mp3EncodeCompleteHandler(event:Event):void
		{
			_mp3Bytes = _mp3Encoder.mp3Data;
			dispatchEvent(new Event(Event.COMPLETE));
		}

		//----------------------------------------------------------------------
		//
		//  Get/Set methods
		//
		//----------------------------------------------------------------------

		public function get mp3Bytes():ByteArray
		{
			return _mp3Bytes;
		}

		public function set mp3Bytes(value:ByteArray):void
		{
			_mp3Bytes = value;
		}
	}
}
