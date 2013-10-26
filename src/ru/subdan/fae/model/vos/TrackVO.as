/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.model.vos
{
	import flash.media.Sound;
	import flash.utils.ByteArray;

	import org.as3wavsound.WavSound;

	public class TrackVO
	{
		public static const FORMAT_MP3_SOUND:String = "sound";
		public static const FORMAT_WAV_SOUND:String = "wav_sound";

		public var id:String;
		public var url:String;

		public var soundFormat:String = FORMAT_MP3_SOUND;
		public var mp3Sound:Sound;
		public var wavSound:WavSound;
		public var wavBytes:ByteArray;
		public var mp3Bytes:ByteArray;

		public var volumesArray:Vector.<Number>;
		public var waveformCreated:Boolean = false;

		public function free():void
		{
			mp3Sound = null;
			wavSound = null;

			if (wavBytes)
			{
				wavBytes.clear();
				wavBytes = null;
			}

			if (mp3Bytes)
			{
				mp3Bytes.clear();
				mp3Bytes = null;
			}

			volumesArray = new <Number>[];
		}
	}
}
