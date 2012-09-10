package com.asbox.utils.constrain
{
	import flash.display.DisplayObject;
	import flash.display.NativeWindow;
	import flash.display.Stage;
	import flash.utils.Dictionary;

	public class Constrain
	{
		public static const ALL:uint = 1;
		public static const LEFT:uint = 2;
		public static const RIGHT:uint = 4;
		public static const TOP:uint = 8;
		public static const BOTTOM:uint = 16;
		public static const CENTER:uint = 32;
		
		private static var _constrains:Dictionary = new Dictionary(true);
			
		public static function Add(object:DisplayObject, size:uint, padding:int = 0, parent:Object = null):void
		{						
			if(object.parent == null && parent == null)
				return;
			
			if(_constrains[object] != null){
				_constrains[object].Dispose();
				delete _constrains[object];
			}
				
			_constrains[object] = new ConstrainObject(object, size, padding, parent);
		}
		
		public static function Apply(object:DisplayObject, size:uint, padding:int = 0, parent:Object = null):void
		{
			if(parent == null && object.parent != null)
				parent = object.parent;
			
			if(object.parent == null && parent == null)
				return;
			
			var ParentWidth:Number = parent.width;
			var ParentHeight:Number = parent.height;
			
			if(parent is Stage)
			{
				ParentWidth = parent.stageWidth;
				ParentHeight = parent.stageHeight;
			}
			
			if(parent is NativeWindow)
			{
				ParentWidth = parent.stage.stageWidth;
				ParentHeight = parent.stage.stageHeight;
			}
							
			if(size & LEFT)
				object.x = padding;
			
			if(size & RIGHT)
				object.x = ParentWidth - object.width - padding;
			
			if(size & TOP)
				object.y = padding;
			
			if(size & BOTTOM)
				object.y = ParentHeight - object.height - padding;
			
			if(size & CENTER)
			{
				object.x = (ParentWidth - object.width) * .5;
				object.y = (ParentHeight - object.height) * .5;
			}
			
			if(size & ALL){
				object.width = ParentWidth - padding * 2;				
				object.height = ParentHeight - padding * 2;
				object.x = object.y = padding;
			}
		}
		
		public static function ClearAllConstrains():void
		{
			if(_constrains)
			{
				for(var key:Object in _constrains)
				{
					_constrains[key].Dispose();
					delete _constrains[key];
				}
			}			
		}
	}
}