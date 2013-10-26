/**
 * Created by IntelliJ IDEA 12
 * Date: 18.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.utils
{
	import flash.utils.ByteArray;

	public class Utils
	{
		public static function cloneByteArray(value:ByteArray):ByteArray
		{
			var ba:ByteArray = new ByteArray();
			ba.writeObject(value);
			ba.position = 0;
			return ba.readObject() as ByteArray;
		}
	}
}
