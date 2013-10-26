/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.create
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.media.Sound;
	import flash.net.URLRequest;

	import org.robotlegs.mvcs.Command;

	import ru.subdan.fae.controller.events.FromJSEvent;
	import ru.subdan.fae.model.TracksModel;
	import ru.subdan.fae.model.vos.TrackVO;

	public class CreateTrackFromURLCommand extends Command
	{
		[Inject]
		public var event:FromJSEvent;

		[Inject]
		public var model:TracksModel;

		private var _id:String;

		override public function execute():void
		{
			var track:TrackVO = new TrackVO();
			track.id = event.params.id;
			_id = track.id;
			track.url = event.params.url;
			track.mp3Sound = new Sound();
			track.mp3Sound.addEventListener(ProgressEvent.PROGRESS, onProgress, false, 0, true);
			track.mp3Sound.addEventListener(Event.COMPLETE, onLoaded, false, 0, true);
			track.mp3Sound.load(new URLRequest(track.url));

			commandMap.detain(this);

			model.addTrack(track);
		}

		private function onProgress(event:ProgressEvent):void
		{
			ExternalInterface.call("fae_loadingUrl", _id, "working", event.bytesLoaded / event.bytesTotal);
		}

		private function onLoaded(event:Event):void
		{
			ExternalInterface.call("fae_loadingUrl", _id, "done");
			commandMap.release(this);
		}
	}
}