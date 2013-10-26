/**
 * Created by IntelliJ IDEA 12
 * Date: 16.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.record
{
	import org.robotlegs.mvcs.Command;

	import ru.subdan.fae.controller.events.WAVAvailEvent;
	import ru.subdan.fae.model.TracksModel;
	import ru.subdan.fae.model.vos.TrackVO;

	public class SaveWAVCommand extends Command
	{
		[Inject]
		public var event:WAVAvailEvent;

		[Inject]
		public var model:TracksModel;

		override public function execute():void
		{
			model.currentTrack.wavSound = event.wavSound;
			model.currentTrack.wavBytes = event.wavBytes;
			model.currentTrack.soundFormat = TrackVO.FORMAT_WAV_SOUND;
		}
	}
}