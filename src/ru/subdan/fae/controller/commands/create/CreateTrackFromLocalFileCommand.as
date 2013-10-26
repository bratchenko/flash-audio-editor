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
	import flash.net.FileFilter;
	import flash.net.FileReference;

	import org.robotlegs.mvcs.Command;

	import ru.subdan.fae.controller.events.FromJSEvent;
	import ru.subdan.fae.model.TracksModel;
	import ru.subdan.fae.model.vos.TrackVO;

	public class CreateTrackFromLocalFileCommand extends Command
	{
		[Inject]
		public var event:FromJSEvent;

		[Inject]
		public var model:TracksModel;

		private var _fr:FileReference;
		private var _track:TrackVO;

		override public function execute():void
		{
			_track = new TrackVO();
			_track.id = event.params.id;

			commandMap.detain(this);

			_fr = new FileReference();
			_fr.addEventListener(Event.SELECT, onSelect);
			_fr.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_fr.addEventListener(Event.COMPLETE, onComplete);
			_fr.browse([new FileFilter("MP3 Files", "*.mp3")]);
		}

		private function onProgress(event:ProgressEvent):void
		{
			ExternalInterface.call("fae_loadingLocalFile", _track.id, "working", int(event.bytesLoaded / event.bytesTotal * 100));
		}

		private function onSelect(event:Event):void
		{
			_fr.load();
		}

		private function onComplete(event:Event):void
		{
			_track.mp3Bytes = _fr.data;
			_track.mp3Sound = new Sound();
			_track.mp3Sound.loadCompressedDataFromByteArray(_fr.data, _fr.data.length);

			model.addTrack(_track);

			ExternalInterface.call("fae_loadingLocalFile", _track.id, "done");

			// clear memory
			_fr.removeEventListener(Event.SELECT, onSelect);
			_fr.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			_fr = null;

			commandMap.release(this);
		}
	}
}