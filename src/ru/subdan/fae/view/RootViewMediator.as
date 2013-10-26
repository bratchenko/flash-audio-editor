/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.view
{
	import org.robotlegs.mvcs.Mediator;

	import ru.subdan.fae.controller.events.FromJSEvent;

	public class RootViewMediator extends Mediator
	{
		[Inject]
		public var view:RootView;

		override public function onRegister():void
		{
			addViewListener(FromJSEvent.CREATE_EMPTY_TRACK, dispatch, FromJSEvent);
			addViewListener(FromJSEvent.CREATE_TRACK_FROM_URL, dispatch, FromJSEvent);
			addViewListener(FromJSEvent.CREATE_TRACK_FROM_LOCAL_FILE, dispatch, FromJSEvent);
			addViewListener(FromJSEvent.DELETE_TRACK, dispatch, FromJSEvent);

			addViewListener(FromJSEvent.PLAY_TRACK, dispatch, FromJSEvent);
			addViewListener(FromJSEvent.STOP_TRACK, dispatch, FromJSEvent);
			addViewListener(FromJSEvent.SET_VOLUME, dispatch, FromJSEvent);

			addViewListener(FromJSEvent.RECORD, dispatch, FromJSEvent);
			addViewListener(FromJSEvent.STOP_RECORDING, dispatch, FromJSEvent);

			addViewListener(FromJSEvent.GENERATE_WAVEFORM, dispatch, FromJSEvent);

			addViewListener(FromJSEvent.UPLOAD, dispatch, FromJSEvent);
			addViewListener(FromJSEvent.STOP_UPLOADING, dispatch, FromJSEvent);
		}
	}
}