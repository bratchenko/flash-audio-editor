/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.events
{
	import flash.events.Event;

	public class RecorderEvent extends Event
	{
		public static const REQUEST_RECORD:String = "onREQUEST_RECORD";
		public static const REQUEST_STOP_RECORDING:String = "onREQUEST_STOP_RECORDING";

		protected var _id:String;

		public function RecorderEvent(type:String, idVal:String = "0")
		{
			super(type);
			_id = idVal;
		}

		public function get id():String
		{
			return _id;
		}

		override public function clone():Event
		{
			return new RecorderEvent(type, id);
		}
	}
}