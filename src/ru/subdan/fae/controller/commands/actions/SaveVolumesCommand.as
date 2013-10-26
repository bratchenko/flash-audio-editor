/**
 * Created by IntelliJ IDEA 12
 * Date: 17.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.actions
{
	import org.robotlegs.mvcs.Command;

	import ru.subdan.fae.controller.events.VolumesArrayEvent;
	import ru.subdan.fae.model.TracksModel;

	public class SaveVolumesCommand extends Command
	{
		[Inject]
		public var event:VolumesArrayEvent;

		[Inject]
		public var model:TracksModel;

		override public function execute():void
		{
			model.getTrack(event.trackID).volumesArray = event.volumes;
			model.getTrack(event.trackID).waveformCreated = true;
		}
	}
}