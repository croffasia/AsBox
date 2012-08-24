package com.asbox.utils
{
	public class DelegateFunction
	{		
		public static function create( handler:Function, ...args ):Function
		{
			return function(...innerArgs):*
			{
				return handler.apply( this, innerArgs.concat( args ) );
			}
		}
		
	}
}