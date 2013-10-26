/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.helpers
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.utils.ByteArray;

	import org.as3wavsound.WavSound;

	public class Generator extends Sprite
	{
		private var samples:ByteArray = new ByteArray();

//		private var buffer:BitmapData = new BitmapData(1024, 256, true, 0x00FFFFFF);
//		private var screen:Bitmap = new Bitmap(buffer);
//		private var rect:Rectangle = new Rectangle(0, 0, 1, 0);

		private var sound:Sound;
		private var _soundLenght:int;
		private var _startPosition:Number = 0;
		private var _percent:Number;

		private var _results_bytes:Vector.<Number> = new <Number>[];
		private var _last_results_bytes:Vector.<Number> = new <Number>[];

		public function Generator():void
		{

		}

		public function genereate(_sound:Sound):void
		{
			sound = _sound;

//			addChild(screen);

			_soundLenght = sound.length * 44.1;

			addEventListener(Event.ENTER_FRAME, extractPart);

//			showw();
		}

		private function extractPart(event:Event):void
		{
			if (_soundLenght - _startPosition > 88200)
			{
				_startPosition += sound.extract(samples, 88200);
				_percent = _startPosition / _soundLenght;
			}
			else
			{
				_startPosition += sound.extract(samples, _soundLenght - _startPosition);
				_percent = _startPosition / _soundLenght;

				if (_startPosition / _soundLenght != 1)
				{
					_percent = 1;
					removeEventListener(Event.ENTER_FRAME, extractPart);
				}
				else
				{
					removeEventListener(Event.ENTER_FRAME, extractPart);
				}
			}

			showw();

			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _startPosition / 44.1, sound.length));

			if (_percent == 1) end();
		}

		private var xPos:uint = 0;
		private var lastPos:uint = 0;

		private function showw():void
		{
			samples.position = lastPos;

			while (samples.bytesAvailable >= 88200)
			{
				var leftMax:Number = Number.MIN_VALUE;
				var rightMax:Number = Number.MIN_VALUE;

				for (var i:uint = 0; i < 11025; i++)
				{
					var leftChannel:Number = Math.abs(samples.readFloat());
					var rightChannel:Number = Math.abs(samples.readFloat());

					if (leftChannel > leftMax) leftMax = leftChannel;
					if (rightChannel > rightMax) rightMax = rightChannel;
				}

				var monoChannel:Number = Math.abs(Math.max(leftMax, rightMax));

//				rect.x = xPos;
//				rect.y = 100 - monoChannel * 100;
//				rect.height = monoChannel * 100;

				_results_bytes.push(monoChannel);
				_last_results_bytes.push(monoChannel);

//				buffer.fillRect(rect, 0xFF5D96DA);

//				xPos += 1;
			}

			lastPos = samples.position;
		}

		public function end():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
			samples.clear();
		}

		public function get results_bytes():Vector.<Number>
		{
			return _results_bytes;
		}

		public function get last_results_bytes():Vector.<Number>
		{
			return _last_results_bytes;
		}

		public function freePartVec():void
		{
			_last_results_bytes = new <Number>[];
		}
	}
}