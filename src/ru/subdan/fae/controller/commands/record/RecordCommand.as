/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.record
{
	import org.robotlegs.mvcs.Command;

	import ru.subdan.fae.controller.events.FromJSEvent;
	import ru.subdan.fae.controller.events.RecorderEvent;
	import ru.subdan.fae.model.TracksModel;
	import ru.subdan.fae.model.vos.TrackVO;

	public class RecordCommand extends Command
	{
		[Inject]
		public var event:FromJSEvent;

		[Inject]
		public var model:TracksModel;

		override public function execute():void
		{
			var track:TrackVO = model.getTrack(event.params.id);
			if (track)
				dispatch(new RecorderEvent(RecorderEvent.REQUEST_RECORD, track.id));
		}
	}
}