/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.bootstraps
{
	import org.robotlegs.core.IMediatorMap;

	import ru.subdan.fae.view.PlayerView;
	import ru.subdan.fae.view.PlayerViewMediator;
	import ru.subdan.fae.view.RecorderView;
	import ru.subdan.fae.view.RecorderViewMediator;
	import ru.subdan.fae.view.RootView;
	import ru.subdan.fae.view.RootViewMediator;

	public class BootstrapViewMediators
	{
		public function BootstrapViewMediators(mediatorMap:IMediatorMap)
		{
			mediatorMap.mapView(PlayerView, PlayerViewMediator);
			mediatorMap.mapView(RecorderView, RecorderViewMediator);
			mediatorMap.mapView(RootView, RootViewMediator);
		}
	}
}
