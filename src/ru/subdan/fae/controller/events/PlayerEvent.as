/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.events
{
	import flash.events.Event;

	import ru.subdan.fae.model.vos.TrackVO;

	public class PlayerEvent extends Event
	{
		public static const REQUEST_PLAY_TRACK:String = "onREQUEST_PLAY_TRACK";
		public static const REQUEST_STOP_TRACK:String = "onREQUEST_STOP_TRACK";

		protected var _trackVO:TrackVO;
		protected var _startSecond:Number = 0;
		protected var _endSecond:Number = 0;

		public function PlayerEvent(type:String, trackVOValue:TrackVO = null, startPosValue:Number = 0, endPosValue:Number = 0)
		{
			super(type);
			_trackVO = trackVOValue;
			_startSecond = startPosValue;
			_endSecond = endPosValue;
		}

		public function get startSecond():Number
		{
			return _startSecond;
		}

		public function get endSecond():Number
		{
			return _endSecond;
		}

		public function get trackVO():TrackVO
		{
			return _trackVO;
		}

		override public function clone():Event
		{
			return new PlayerEvent(type, trackVO, _startSecond, _endSecond);
		}
	}
}