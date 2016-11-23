package com.jbouguima.nicedates.simplepicker.abstracts
{
	import com.jbouguima.nicedates.simplepicker.events.ChooserDateEvent;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	
	import spark.components.supportClasses.ItemRenderer;
	
	
	[Bindable]
	public class AbstractDateChooserRenderer extends ItemRenderer
	{
		public var bckColor:SolidColor;
		//public var bordColor:SolidColorStroke;
		public var itemBackColor:uint;
		private var itemDate:ChooserDateListDay;
		
		private var isSelectedDate:Boolean;
		
		public function AbstractDateChooserRenderer()
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, init);
			
		}
		
		public function clickedHandler(e:MouseEvent):void
		{
			var evt:ChooserDateEvent = new ChooserDateEvent(ChooserDateEvent.DAY_SELECTED, true, false);
			evt.changedDate = itemDate.date;
			dispatchEvent(evt);
		}
		
		public function init(e:FlexEvent):void
		{
			//if(this.parent) this.parent.addEventListener(MouseEvent.CLICK, clickedHandler);
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandlr);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandlr);
			addEventListener(MouseEvent.CLICK, clickedHandler);
		}
		
		private function rollOverHandlr(evt:MouseEvent):void
		{
			bckColor.color = 0xe0e0e0;
		}
		
		private function rollOutHandlr(evt:MouseEvent):void
		{
			bckColor.color = itemBackColor;
		}
		
		override public function set data(value:Object):void {
			
			if(value){
				itemDate = value as ChooserDateListDay;
				labelDisplay.text = itemDate.dateLabel;
				isSelectedDate = itemDate.choosenDate;
				var dt:Date = new Date();
				
				
				if((itemDate.date.date==dt.date) && (itemDate.currentDateMonth) && (itemDate.currentMonth)){
					itemBackColor = 0x29b3f3;
					//bordColor.alpha = 0;
					labelDisplay.setStyle('color',0xffffff);
				}else{
					if((itemDate.date.day == 6) || (itemDate.date.day == 0)){
						if(itemDate.currentMonth){
							//bckColor.color = 0xfecaca;
							//bordColor.alpha = 0;
							labelDisplay.setStyle('color',0xce0000);
						}else{
							//bckColor.color = 0xfdecec;								
							labelDisplay.setStyle('color',0xfbb9b9);
						}
						itemBackColor = 0xffffff;
					}else if(isSelectedDate){
						if(itemDate.currentMonth){
							itemBackColor = 0xf87308;
						}else {
							itemBackColor = 0xe7b185
						}
						
						//bordColor.alpha = 0;
						labelDisplay.setStyle('color',0xffffff);
					}else{
						itemBackColor = 0xffffff;
						if(value.currentMonth){
							labelDisplay.setStyle('color',0x2b2b2b);
						}else{
							labelDisplay.setStyle('color',0xa0a0a0);
						}
					}
				}
				
				bckColor.color = itemBackColor;
			}
		}
		
		
		
	}
}