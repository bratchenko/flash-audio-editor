/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.controller.bootstraps
{
	import org.robotlegs.core.IInjector;

	import ru.subdan.fae.service.UploadService;

	public class BootstrapServices
	{
		public function BootstrapServices(injector:IInjector)
		{
			injector.mapSingleton(UploadService);
		}
	}
}
