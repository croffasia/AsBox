/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.utils 
{	
	import com.asbox.AsBox;
	
	import flash.display.NativeWindow;
	import flash.display.Screen;

	/**
	 * Alignment AIR Native window in Screen
	 * @author Poluosmak Andrew
	 */
	public class DisplayAlignUtils 
	{
		/**
		 * Align to left
		 */
		public static function Left(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = 0 + currentScreen.visibleBounds.x;
		}
		
		/**
		 * Align to top and left
		 */
		public static function LeftTop(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = 0 + currentScreen.visibleBounds.x;
			object.y = 0 + currentScreen.visibleBounds.y;
		}
		
		/**
		 * Align to bottom and left
		 */
		public static function LeftBottom(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = 0 + currentScreen.visibleBounds.x;
			object.y = currentScreen.visibleBounds.y + currentScreen.visibleBounds.height - object.height;
		}
		
		/**
		 * Align to center and center
		 */
		public static function LeftCenter(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = 0 + currentScreen.visibleBounds.x;
			object.y = currentScreen.visibleBounds.y + currentScreen.visibleBounds.height * .5 - object.height * .5;
		}
		
		/**
		 * Align to right
		 */
		public static function Right(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = currentScreen.visibleBounds.x + currentScreen.visibleBounds.width - object.width;
		}
		
		/**
		 * Align to top and right
		 */
		public static function RightTop(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = currentScreen.visibleBounds.x + currentScreen.visibleBounds.width - object.width;
			object.y = 0 + currentScreen.visibleBounds.y;
		}
		
		/**
		 * Align to bottom and right
		 */
		public static function RightBottom(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = currentScreen.visibleBounds.x + currentScreen.visibleBounds.width - object.width;
			object.y = currentScreen.visibleBounds.y + currentScreen.visibleBounds.height - object.height;
		}
		
		/**
		 * Align to center and right
		 */
		public static function RghtCenter(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = currentScreen.visibleBounds.x + currentScreen.visibleBounds.width - object.width;
			object.y = currentScreen.visibleBounds.y + currentScreen.visibleBounds.height * .5 - object.height * .5;
		}
		
		/**
		 * Align to top
		 */
		public static function Top(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.y = currentScreen.visibleBounds.y;
		}
		
		/**
		 * Align to bottom
		 */
		public static function Bottom(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.y = currentScreen.visibleBounds.y + currentScreen.visibleBounds.height - object.height;
		}
		
		/**
		 * Align to center
		 */
		public static function Centered(object:NativeWindow):void 
		{			
			var currentScreen:Screen = DisplayAlignUtils.getCurrentScreen();
            object.x = currentScreen.visibleBounds.x + (currentScreen.visibleBounds.width - object.width) * .5;
            object.y = currentScreen.visibleBounds.y + (currentScreen.visibleBounds.height - object.height ) * .5;
			object.title = "Centered window";
		}
		
		/**
		 * Current Screen
		 * @return Screen
		 */
		public static function getCurrentScreen():Screen
		{ 
            var current:Screen; 
            var screens:Array = Screen.getScreensForRectangle(AsBox.container.stage.nativeWindow.bounds); 
            (screens.length > 0) ? current = screens[0] : current = Screen.mainScreen; 
            return current; 
        } 
	}

}