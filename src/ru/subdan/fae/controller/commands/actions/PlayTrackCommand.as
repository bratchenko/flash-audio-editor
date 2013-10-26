/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.actions
{
	import org.robotlegs.mvcs.Command;

	import ru.subdan.fae.controller.events.FromJSEvent;
	import ru.subdan.fae.controller.events.PlayerEvent;
	import ru.subdan.fae.model.TracksModel;
	import ru.subdan.fae.model.vos.TrackVO;

	public class PlayTrackCommand extends Command
	{
		[Inject]
		public var event:FromJSEvent;

		[Inject]
		public var model:TracksModel;

		override public function execute():void
		{
			var track:TrackVO = model.getTrack(event.params.id);
			if (track)
				dispatch(new PlayerEvent(PlayerEvent.REQUEST_PLAY_TRACK, track, event.params.startSecond, event.params.endSecond));
		}
	}
}