/**
 * Created by IntelliJ IDEA 12
 * Date: 17.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.service
{
	import com.junkbyte.console.Cc;

	import flash.events.Event;

	import ru.subdan.fae.controller.events.TaskEvent;
	import ru.subdan.fae.model.vos.Task;
	import ru.subdan.fae.model.vos.TrackVO;

	public class UploadService
	{
		private var _tasks:Vector.<Task> = new <Task>[];

		//----------------------------------------------------------------------
		//
		//  PUBLIC METHODS
		//
		//----------------------------------------------------------------------

		public function upload(trackVO:TrackVO, url:String, name:String, data:String):void
		{
			var task:Task = new Task(trackVO, url, name, data);
			task.addEventListener(TaskEvent.TASK_COMPLETED, onTaskCompleted);
			task.beginTask();

			_tasks.push(task);

			CONFIG::debug { Cc.add("UploadService: добавлена новая задача загрузки трека " + task.trackVO.id);}
			CONFIG::debug { Cc.add("UploadService: текущая задача = " + task.trackVO.id);}
		}

		public function stopUploading(id:String):void
		{
			trace("want to stop uploading " + id + " track");

			for (var i:int = 0; i < _tasks.length; i++)
			{
				if (_tasks[i].trackVO.id == id)
				{
					trace("task finded as " + id + " track");

					_tasks[i].stopUploading();
					_tasks[i].removeEventListener(TaskEvent.TASK_COMPLETED, onTaskCompleted);
					_tasks.splice(_tasks.indexOf(_tasks[i]), 1);
					break;
				}
			}
		}

		//----------------------------------------------------------------------
		//
		//  EVENT HANDLERS
		//
		//----------------------------------------------------------------------

		private function onTaskCompleted(event:TaskEvent):void
		{
			event.task.removeEventListener(TaskEvent.TASK_COMPLETED, onTaskCompleted);
			_tasks.splice(_tasks.indexOf(event.task), 1);
		}
	}
}
