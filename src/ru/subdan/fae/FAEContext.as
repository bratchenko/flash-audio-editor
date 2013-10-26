/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae
{
	import flash.display.DisplayObjectContainer;

	import org.robotlegs.mvcs.Context;

	import ru.subdan.fae.controller.bootstraps.BootstrapCommands;

	import ru.subdan.fae.controller.bootstraps.BootstrapModels;
	import ru.subdan.fae.controller.bootstraps.BootstrapServices;
	import ru.subdan.fae.controller.bootstraps.BootstrapViewMediators;

	import ru.subdan.fae.view.RootView;

	public class FAEContext extends Context
	{
		private var _rootView:RootView;

		public function FAEContext(contextView:DisplayObjectContainer)
		{
			super(contextView);
		}

		override public function startup():void
		{
			new BootstrapModels(injector);
			new BootstrapServices(injector);
			new BootstrapCommands(commandMap);
			new BootstrapViewMediators(mediatorMap);

			addRootView();

			super.startup();
		}

		private function addRootView():void
		{
			_rootView = new RootView();
			contextView.addChild(_rootView);
		}
	}
}