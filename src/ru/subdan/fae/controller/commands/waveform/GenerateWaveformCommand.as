/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.waveform
{
	import by.blooddy.crypto.serialization.JSON;

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.utils.getTimer;

	import org.robotlegs.mvcs.Command;

	import ru.subdan.fae.controller.commands.helpers.Generator;
	import ru.subdan.fae.controller.events.FromJSEvent;
	import ru.subdan.fae.model.TracksModel;
	import ru.subdan.fae.model.vos.TrackVO;

	public class GenerateWaveformCommand extends Command
	{
		[Inject]
		public var event:FromJSEvent;

		[Inject]
		public var model:TracksModel;

		private var _track:TrackVO;
		private var _generator:Generator;
		private var delta:int;

		override public function execute():void
		{
			commandMap.detain(this);

			_track = model.getTrack(event.params.id);

			if (!_track)
			{
				ExternalInterface.call("fae_generatingWaveform", event.params.id, "error", "Track with id = " + event.params.id + " not found.");
			}

			if (_track.waveformCreated)
			{
				ExternalInterface.call("fae_generatingWaveform", _track.id, "done", 1, by.blooddy.crypto.serialization.JSON.encode(_track.volumesArray));
			}
			else
			{
				_generator = new Generator();
				_generator.addEventListener(ProgressEvent.PROGRESS, onGenerating);
				_generator.addEventListener(Event.COMPLETE, onComplete);
				_generator.genereate(_track.mp3Sound);

				contextView.addChild(_generator);
			}
		}

		private function onGenerating(event:ProgressEvent):void
		{
			if (getTimer() - delta >= 250)
			{
				ExternalInterface.call("fae_generatingWaveform", _track.id, "working", event.bytesLoaded/event.bytesTotal, by.blooddy.crypto.serialization.JSON.encode(_generator.last_results_bytes));
				_generator.freePartVec();
				delta = getTimer();
			}
		}

		private function onComplete(event:Event):void
		{
			_track.volumesArray = _generator.results_bytes;
			_track.waveformCreated = true;
			ExternalInterface.call("fae_generatingWaveform", _track.id, "working", 1, by.blooddy.crypto.serialization.JSON.encode(_generator.last_results_bytes));
			ExternalInterface.call("fae_generatingWaveform", _track.id, "done");
			commandMap.release(this);
		}
	}
}
