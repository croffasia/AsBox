package com.asbox.utils.constrain
{
	import com.asbox.AsBox;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class ConstrainObject
	{
		public var object:DisplayObject;
		public var size:uint;
		public var padding:int;
		public var parent:Object;
		
		public function ConstrainObject(object:DisplayObject, size:uint, padding:int = 0, parent:Object = null)
		{
			this.object = object;
			this.size = size;
			this.padding = padding;
			
			if(parent == null && object.parent != null)
				this.parent = object.parent;
			else if(parent != null)
				this.parent = parent;
			else
				return;
			
			Initialize();								
		} 
		
		public function Dispose():void
		{
			AsBox.EM.removeCallbackEvent(onResizeHandler, Event.RESIZE);
		}
		
		protected function Initialize():void
		{
			AsBox.EM.add(parent as IEventDispatcher, Event.RESIZE, onResizeHandler, false, "Constrains");
			onResizeHandler(null);
		}
		
		private function onResizeHandler(event:Event):void
		{
			Constrain.Apply(object, size, padding, parent);
		}
	}
}