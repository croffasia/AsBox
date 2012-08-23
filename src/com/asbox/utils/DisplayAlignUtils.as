package com.asbox.utils 
{
	import com.asbox.Application;
	
	import flash.display.NativeWindow;
	import flash.display.Screen;
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class DisplayAlignUtils 
	{
		public static function Left(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = 0 + currentScreen.visibleBounds.x;
		}
		
		public static function LeftTop(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = 0 + currentScreen.visibleBounds.x;
			object.y = 0 + currentScreen.visibleBounds.y;
		}
		
		public static function LeftBottom(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = 0 + currentScreen.visibleBounds.x;
			object.y = currentScreen.visibleBounds.y + currentScreen.visibleBounds.height - object.height;
		}
		
		public static function LeftCenter(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = 0 + currentScreen.visibleBounds.x;
			object.y = currentScreen.visibleBounds.y + currentScreen.visibleBounds.height * .5 - object.height * .5;
		}
		
		
		public static function Right(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = currentScreen.visibleBounds.x + currentScreen.visibleBounds.width - object.width;
		}
		
		public static function RightTop(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = currentScreen.visibleBounds.x + currentScreen.visibleBounds.width - object.width;
			object.y = 0 + currentScreen.visibleBounds.y;
		}
		
		public static function RightBottom(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = currentScreen.visibleBounds.x + currentScreen.visibleBounds.width - object.width;
			object.y = currentScreen.visibleBounds.y + currentScreen.visibleBounds.height - object.height;
		}
		
		public static function RghtCenter(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = currentScreen.visibleBounds.x + currentScreen.visibleBounds.width - object.width;
			object.y = currentScreen.visibleBounds.y + currentScreen.visibleBounds.height * .5 - object.height * .5;
		}
		
		public static function Top(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.y = currentScreen.visibleBounds.y;
		}
		
		public static function Bottom(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.y = currentScreen.visibleBounds.y + currentScreen.visibleBounds.height - object.height;
		}
		
		public static function Centered(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = currentScreen.visibleBounds.x + (currentScreen.visibleBounds.width - object.width) * .5;
            object.y = currentScreen.visibleBounds.y + (currentScreen.visibleBounds.height - object.height ) * .5;
			object.title = "Centered window";
		}
		
		public static function getCurrentScreen():Screen
		{ 
            var current:Screen; 
            var screens:Array = Screen.getScreensForRectangle(Application.instance.stage.nativeWindow.bounds); 
            (screens.length > 0) ? current = screens[0] : current = Screen.mainScreen; 
            return current; 
        } 
	}

}