/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.view
{
	import org.robotlegs.mvcs.Mediator;

	import ru.subdan.fae.controller.events.FromJSEvent;

	import ru.subdan.fae.controller.events.PlayerEvent;

	public class PlayerViewMediator extends Mediator
	{
		[Inject]
		public var view:PlayerView;

		override public function onRegister():void
		{
			addContextListener(PlayerEvent.REQUEST_PLAY_TRACK, onPlay, PlayerEvent);
			addContextListener(PlayerEvent.REQUEST_STOP_TRACK, onStop, PlayerEvent);
			addContextListener(FromJSEvent.SET_VOLUME, onSetVolume, FromJSEvent);
		}

		private function onSetVolume(event:FromJSEvent):void
		{
			view.setVolume(event.params.volume);
		}

		private function onPlay(event:PlayerEvent):void
		{
			view.playTrack(event.trackVO, event.startSecond, event.endSecond);
		}

		private function onStop(event:PlayerEvent):void
		{
			view.stopTrack();
		}
	}
}