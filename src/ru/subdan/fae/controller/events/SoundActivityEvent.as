/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.events
{
	import flash.events.Event;

	public class SoundActivityEvent extends Event
	{
		public static const ACT_CHANGED:String = "onACT_CHANGED";

		protected var _value:Number;

		public function SoundActivityEvent(type:String, valueValue:Number)
		{
			super(type);
			_value = valueValue;
		}

		public function get value():Number
		{
			return _value;
		}

		override public function clone():Event
		{
			return new SoundActivityEvent(type, value);
		}
	}
}