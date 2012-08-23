package com.asbox 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class Application extends Sprite 
	{	
		private static var _instance:Application;
		
		public function Application() 
		{
			if (stage)
				InitializeComponents(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, InitializeComponents);		
		}
		
		protected function InitializeComponents(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, InitializeComponents);
			_instance = this;
		}
		
		public static function get instance():Application 
		{
			return _instance;
		}
		
	}

}