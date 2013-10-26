/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.bootstraps
{
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.ICommandMap;

	import ru.subdan.fae.controller.commands.actions.DeleteTrackCommand;
	import ru.subdan.fae.controller.commands.actions.PlayTrackCommand;
	import ru.subdan.fae.controller.commands.actions.SaveVolumesCommand;
	import ru.subdan.fae.controller.commands.actions.StopTrackCommand;
	import ru.subdan.fae.controller.commands.bootstraps.SetupStageCommand;
	import ru.subdan.fae.controller.commands.create.CreateEmptyTrackCommand;
	import ru.subdan.fae.controller.commands.create.CreateTrackFromLocalFileCommand;
	import ru.subdan.fae.controller.commands.create.CreateTrackFromURLCommand;
	import ru.subdan.fae.controller.commands.record.RecordCommand;
	import ru.subdan.fae.controller.commands.record.SaveWAVCommand;
	import ru.subdan.fae.controller.commands.record.StopRecordingCommand;
	import ru.subdan.fae.controller.commands.upload.StopUploadingCommand;
	import ru.subdan.fae.controller.commands.upload.UploadCommand;
	import ru.subdan.fae.controller.commands.waveform.GenerateWaveformCommand;
	import ru.subdan.fae.controller.events.FromJSEvent;
	import ru.subdan.fae.controller.events.VolumesArrayEvent;
	import ru.subdan.fae.controller.events.WAVAvailEvent;

	public class BootstrapCommands
	{
		public function BootstrapCommands(commandMap:ICommandMap)
		{
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, SetupStageCommand, ContextEvent);

			commandMap.mapEvent(FromJSEvent.CREATE_EMPTY_TRACK, CreateEmptyTrackCommand, FromJSEvent);
			commandMap.mapEvent(FromJSEvent.CREATE_TRACK_FROM_URL, CreateTrackFromURLCommand, FromJSEvent);
			commandMap.mapEvent(FromJSEvent.CREATE_TRACK_FROM_LOCAL_FILE, CreateTrackFromLocalFileCommand, FromJSEvent);
			commandMap.mapEvent(FromJSEvent.DELETE_TRACK, StopTrackCommand, FromJSEvent);
			commandMap.mapEvent(FromJSEvent.DELETE_TRACK, DeleteTrackCommand, FromJSEvent);
			commandMap.mapEvent(FromJSEvent.PLAY_TRACK, PlayTrackCommand, FromJSEvent);
			commandMap.mapEvent(FromJSEvent.STOP_TRACK, StopTrackCommand, FromJSEvent);

			commandMap.mapEvent(FromJSEvent.RECORD, RecordCommand, FromJSEvent);
			commandMap.mapEvent(FromJSEvent.STOP_RECORDING, StopRecordingCommand, FromJSEvent);

			commandMap.mapEvent(FromJSEvent.GENERATE_WAVEFORM, GenerateWaveformCommand, FromJSEvent);

			commandMap.mapEvent(FromJSEvent.UPLOAD, UploadCommand, FromJSEvent);
			commandMap.mapEvent(FromJSEvent.STOP_UPLOADING, StopUploadingCommand, FromJSEvent);

			commandMap.mapEvent(WAVAvailEvent.WAV_AVAILABLE, SaveWAVCommand, WAVAvailEvent);
			commandMap.mapEvent(VolumesArrayEvent.VOLUMES_CAPTURED, SaveVolumesCommand, VolumesArrayEvent);
		}
	}
}
