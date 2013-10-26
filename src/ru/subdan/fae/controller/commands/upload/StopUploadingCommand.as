/**
 * Created by IntelliJ IDEA 12
 * Date: 17.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.upload
{
	import org.robotlegs.mvcs.Command;

	import ru.subdan.fae.controller.events.FromJSEvent;
	import ru.subdan.fae.service.UploadService;

	public class StopUploadingCommand extends Command
	{
		[Inject]
		public var event:FromJSEvent;

		[Inject]
		public var uploadService:UploadService;

		override public function execute():void
		{
			uploadService.stopUploading(event.params.id);
		}
	}
}