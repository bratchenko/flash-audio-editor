/**
 * Created by IntelliJ IDEA 12
 * Date: 17.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.events
{
	import flash.events.Event;

	public class VolumesArrayEvent extends Event
	{
		public static const VOLUMES_CAPTURED:String = "onVOLUMES_CAPTURED";

		protected var _volumes:Vector.<Number>;
		protected var _trackID:String;

		public function VolumesArrayEvent(type:String,
		                                  volumesValue:Vector.<Number>, trackIDValue:String)
		{
			super(type);
			_volumes = volumesValue;
			_trackID = trackIDValue;
		}

		public function get trackID():String
		{
			return _trackID;
		}

		public function get volumes():Vector.<Number>
		{
			return _volumes;
		}

		override public function clone():Event
		{
			return new VolumesArrayEvent(type, volumes, trackID);
		}
	}
}