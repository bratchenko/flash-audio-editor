package
{
	import flash.display.Sprite;

	import ru.subdan.fae.FAEContext;

	public class Main extends Sprite
	{
		private var _context:FAEContext;

		public function Main()
		{
			_context = new FAEContext(this);
		}
	}
}
