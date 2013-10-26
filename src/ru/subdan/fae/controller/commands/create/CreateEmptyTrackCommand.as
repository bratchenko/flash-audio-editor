/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.create
{
	import ru.subdan.fae.controller.events.FromJSEvent;
	import ru.subdan.fae.model.TracksModel;
	import ru.subdan.fae.model.vos.TrackVO;

	public class CreateEmptyTrackCommand
	{
		[Inject]
		public var event:FromJSEvent;

		[Inject]
		public var model:TracksModel;

		public function execute():void
		{
			var track:TrackVO = new TrackVO();
			track.id = event.params.id;

			model.addTrack(track);
		}
	}
}