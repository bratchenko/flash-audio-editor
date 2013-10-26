/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.commands.bootstraps
{
	import com.junkbyte.console.Cc;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.external.ExternalInterface;
	import flash.ui.ContextMenu;

	import org.robotlegs.mvcs.Command;

	public class SetupStageCommand extends Command
	{
		override public function execute():void
		{
			contextView.stage.scaleMode = StageScaleMode.NO_SCALE;
			contextView.stage.align = StageAlign.TOP_LEFT;

			var cm:ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			contextView.contextMenu = cm;

			ExternalInterface.call("fae_ready");

			// Запуск логгера
			CONFIG::debug
			{
				Cc.config.keystrokePassword = "123";
				Cc.start(null);
				Cc.remoting = true;
			}
		}
	}
}