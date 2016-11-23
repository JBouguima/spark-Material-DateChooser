package com.jbouguima.nicedates.simplepicker.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayList;
	
	[Bindable]
	public class ChooserDateEvent extends Event
	{
		public static var YEARS_GROUP_SELECTED:String = "yearsGroupSelected";
		public static var YEAR_SELECTED:String = "yearSelected";
		public static var MONTH_SELECTED:String = "monthSelected";
		public static var DAY_SELECTED:String = "daySelected";
		public static var SELECTED_DATE_CHANGED:String = "selectedDateChanged";
		public static var OPEN_CALENDAR_ON_EDITABLE:String = "openChooserOnEditable";
		public static var DATE_INPUT_FINISHED:String = "dateInputFinished";
		
		public var yearsGroup:Object;
		public var yearSelected:Number;
		public var monthSelected:Number;
		public var changedDate:Date;
		
		public function ChooserDateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}