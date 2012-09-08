/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.components 
{
	import com.asbox.components.base.ComponentContainer;
	import com.asbox.components.interfaces.IComponent;
	import com.asbox.managers.ComponentManager;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class Component extends ComponentContainer implements IComponent 
	{				
		public function Component() 
		{					
			ComponentManager.getInstance().Register(this);						
		}		
	}

}