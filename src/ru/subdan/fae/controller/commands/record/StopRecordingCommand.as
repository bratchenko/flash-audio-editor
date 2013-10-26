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

	public class StopRecordingCommand extends Command
	{
		[Inject]
		public var event:FromJSEvent;

		override public function execute():void
		{
			dispatch(new RecorderEvent(RecorderEvent.REQUEST_STOP_RECORDING));
		}
	}
}