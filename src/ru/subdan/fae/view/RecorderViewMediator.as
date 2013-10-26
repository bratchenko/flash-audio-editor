/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.view
{
	import org.robotlegs.mvcs.Mediator;

	import ru.subdan.fae.controller.events.RecorderEvent;
	import ru.subdan.fae.controller.events.VolumesArrayEvent;
	import ru.subdan.fae.controller.events.WAVAvailEvent;

	public class RecorderViewMediator extends Mediator
	{
		[Inject]
		public var view:RecorderView;

		override public function onRegister():void
		{
			addContextListener(RecorderEvent.REQUEST_RECORD, onRec, RecorderEvent);
			addContextListener(RecorderEvent.REQUEST_STOP_RECORDING, onReqStop, RecorderEvent);

			addViewListener(VolumesArrayEvent.VOLUMES_CAPTURED, dispatch, VolumesArrayEvent);
			addViewListener(WAVAvailEvent.WAV_AVAILABLE, dispatch, WAVAvailEvent);
		}

		private function onRec(event:RecorderEvent):void
		{
			view.startRecord(event.id);
		}

		private function onReqStop(event:RecorderEvent):void
		{
			view.stopRecord();
		}
	}
}