/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.events
{
	import flash.events.Event;

	public class FromJSEvent extends Event
	{
		public static const CREATE_EMPTY_TRACK:String = "onCREATE_EMPTY_TRACK";
		public static const CREATE_TRACK_FROM_URL:String = "onCREATE_TRACK_FROM_URL";
		public static const CREATE_TRACK_FROM_LOCAL_FILE:String = "onCREATE_TRACK_FROM_LOCAL_FILE";
		public static const DELETE_TRACK:String = "onDELETE_TRACK";

		public static const PLAY_TRACK:String = "onPLAY_TRACK";
		public static const STOP_TRACK:String = "onSTOP_TRACK";
		public static const SET_VOLUME:String = "onSET_VOLUME";

		public static const RECORD:String = "onRECORD";
		public static const STOP_RECORDING:String = "onSTOP_RECORDING";

		public static const GENERATE_WAVEFORM:String = "onGENERATE_WAVEFORM";

		public static const UPLOAD:String = "onUPLOAD";
		public static const STOP_UPLOADING:String = "onSTOP_UPLOADING";

		protected var _params:Object;

		public function FromJSEvent(type:String, paramsValue:Object)
		{
			super(type);
			_params = paramsValue;
		}

		public function get params():Object
		{
			return _params;
		}

		override public function clone():Event
		{
			return new FromJSEvent(type, params);
		}
	}
}