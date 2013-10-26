/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.bootstraps
{
	import org.robotlegs.core.IInjector;

	import ru.subdan.fae.model.TracksModel;

	public class BootstrapModels
	{
		public function BootstrapModels(injector:IInjector)
		{
			injector.mapSingleton(TracksModel);
		}
	}
}
