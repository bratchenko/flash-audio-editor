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
	import ru.subdan.fae.model.TracksModel;
	import ru.subdan.fae.service.UploadService;

	public class UploadCommand extends Command
	{
		[Inject]
		public var event:FromJSEvent;

		[Inject]
		public var uploadService:UploadService;

		[Inject]
		public var model:TracksModel;

		override public function execute():void
		{
			uploadService.upload(model.getTrack(event.params.id), event.params.url, event.params.name, event.params.data);
		}
	}
}