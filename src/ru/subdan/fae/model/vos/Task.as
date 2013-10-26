/**
 * Created by IntelliJ IDEA 12
 * Date: 17.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.model.vos
{
	import by.blooddy.crypto.serialization.JSON;

	import com.junkbyte.console.Cc;

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLVariables;

	import ru.inspirit.net.MultipartURLLoader;
	import ru.subdan.fae.controller.commands.helpers.Converter;
	import ru.subdan.fae.controller.events.TaskEvent;

	public class Task extends EventDispatcher
	{
		public var trackVO:TrackVO;
		public var url:String;
		public var name:String;
		public var data:String;

		private var _converter:Converter;
		private var _uploader:MultipartURLLoader;

		public function Task(trackVO:TrackVO, url:String, name:String,
		                       data:String)
		{
			this.trackVO = trackVO;
			this.url = url;
			this.name = name;
			this.data = data;

			_converter = new Converter();
			_converter.addEventListener(ErrorEvent.ERROR, onError);
			_converter.addEventListener(ProgressEvent.PROGRESS, onConverting);
			_converter.addEventListener(Event.COMPLETE, convertComplete);

			_uploader = new MultipartURLLoader();
			_uploader.addEventListener(Event.COMPLETE, onUploaded);
		}

		//----------------------------------------------------------------------
		//
		//  EVENT HANDLERS
		//
		//----------------------------------------------------------------------

		private function onError(event:ErrorEvent):void
		{
			ExternalInterface.call("fae_uploading", trackVO.id, "error");
			dispatchEvent(new TaskEvent(TaskEvent.TASK_COMPLETED, this));
		}

		private function onConverting(event:ProgressEvent):void
		{
			CONFIG::debug { Cc.add("UploadService: конвертация... " + int(event.bytesLoaded / event.bytesTotal * 100));}
			ExternalInterface.call("fae_uploading", trackVO.id, "converting", event.bytesLoaded / event.bytesTotal);
		}

		private function convertComplete(event:Event):void
		{
			// MP3 байты получены
			// Сохраняем их
			trackVO.mp3Bytes = _converter.mp3Bytes;
			trackVO.mp3Bytes.position = 0;
			trackVO.mp3Sound = new Sound();
			trackVO.mp3Sound.loadCompressedDataFromByteArray(trackVO.mp3Bytes, trackVO.mp3Bytes.length);
			trackVO.wavBytes.clear();
			trackVO.soundFormat = TrackVO.FORMAT_MP3_SOUND;
			trackVO.wavSound = null;

			CONFIG::debug { Cc.add("UploadService: MP3 получен из WAV");}

			// Отправляем их
			proceedTask();
		}

		private function onUploaded(event:Event):void
		{
			var loader:URLLoader = MultipartURLLoader(event.currentTarget).loader;
			CONFIG::debug { Cc.add("UploadService: данные загружены. Ответ: " + loader.data);}
			ExternalInterface.call("fae_uploading", trackVO.id, "done", 1);

			_converter.free();

			dispatchEvent(new TaskEvent(TaskEvent.TASK_COMPLETED, this));
		}

		//----------------------------------------------------------------------
		//
		//  PRIVATE METHODS
		//
		//----------------------------------------------------------------------

		private function proceedTask():void
		{
			CONFIG::debug { Cc.add("UploadService: отправка звука на сервер... ");}

			_uploader.clearFiles();
			_uploader.clearVariables();
			//
			var data:Object = by.blooddy.crypto.serialization.JSON.decode(data);
			for (var property:String in data)
				_uploader.addVariable(property, data[property]);
			//
			_uploader.addVariable("name", name);
			_uploader.addFile(trackVO.mp3Bytes, trackVO.id + ".mp3", name, "multipart/form-data");

			_uploader.load(url);
			ExternalInterface.call("fae_uploading", trackVO.id, "uploading", 0);
		}

		//----------------------------------------------------------------------
		//
		//  PUBLIC METHODS
		//
		//----------------------------------------------------------------------

		public function beginTask():void
		{
			CONFIG::debug { Cc.add("UploadService: задача " + trackVO.id + "начата ");}

			// Если MP3 байтов нет, то нужно их получить
			if (!trackVO.mp3Bytes)
			{
				// Если звук в WAVе
				if (trackVO.soundFormat == TrackVO.FORMAT_WAV_SOUND)
				{
					// конвертируем его в mp3
					CONFIG::debug { Cc.add("UploadService: конвертация звука в MP3... ");}
					trackVO.wavBytes.position = 0;
					_converter.convertToMP3(trackVO.wavBytes);
				}
			}
			// Если есть mp3 байты
			else
			{
				proceedTask();
			}
		}

		public function stopUploading():void
		{
			_uploader.dispose();
			_uploader.removeEventListener(Event.COMPLETE, onUploaded);
			_uploader = null;

			_converter.free();
			_converter.removeEventListener(ErrorEvent.ERROR, onError);
			_converter.removeEventListener(ProgressEvent.PROGRESS, onConverting);
			_converter.removeEventListener(Event.COMPLETE, convertComplete);
			_converter = null;
		}
	}
}
