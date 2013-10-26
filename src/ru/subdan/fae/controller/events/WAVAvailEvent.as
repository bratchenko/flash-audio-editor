/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.events
{
	import flash.events.Event;
	import flash.utils.ByteArray;

	import org.as3wavsound.WavSound;

	public class WAVAvailEvent extends Event
	{
		public static const WAV_AVAILABLE:String = "onWAV_AVAILABLE";

		protected var _wavSound:WavSound;
		protected var _wavBytes:ByteArray;

		public function WAVAvailEvent(type:String, wavSoundValue:WavSound, wavBytesValue:ByteArray)
		{
			super(type);
			_wavSound = wavSoundValue;
			_wavBytes = wavBytesValue;
		}

		public function get wavSound():WavSound
		{
			return _wavSound;
		}

		public function get wavBytes():ByteArray
		{
			return _wavBytes;
		}

		override public function clone():Event
		{
			return new WAVAvailEvent(type, wavSound, wavBytes);
		}
	}
}