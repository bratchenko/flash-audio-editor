/**
 * Created by IntelliJ IDEA 12
 * Date: 19.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.events
{
	import flash.events.Event;

	import ru.subdan.fae.model.vos.Task;

	public class TaskEvent extends Event
	{
		public static const TASK_COMPLETED:String = "onTASK_COMPLETED";

		protected var _task:Task;

		public function TaskEvent(type:String, taskValue:Task)
		{
			super(type);
			_task = taskValue;
		}

		public function get task():Task
		{
			return _task;
		}

		override public function clone():Event
		{
			return new TaskEvent(type, task);
		}
	}
}