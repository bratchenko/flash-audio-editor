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

	public class StopTrackCommand extends Command
	{
		[Inject]
		public var event:FromJSEvent;

		[Inject]
		public var model:TracksModel;

		override public function execute():void
		{
			dispatch(new PlayerEvent(PlayerEvent.REQUEST_STOP_TRACK));
		}
	}
}