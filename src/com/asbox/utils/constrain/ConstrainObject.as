package com.asbox.utils.constrain
{
	import com.asbox.AsBox;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;

	public class ConstrainObject
	{
		public var object:DisplayObject;
		public var size:uint;
		public var padding:Point;
		public var parent:Object;
		
		public function ConstrainObject(object:DisplayObject, size:uint, padding:Point = null, parent:Object = null)
		{
			this.object = object;
			this.size = size;
			
			if(padding == null)
				padding = new Point(0, 0);
			
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