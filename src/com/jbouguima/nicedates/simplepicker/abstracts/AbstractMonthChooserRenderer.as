package com.jbouguima.nicedates.simplepicker.abstracts
{
	
	import com.jbouguima.nicedates.simplepicker.parts.YearRenderer;
	
	import spark.components.Label;
	import spark.components.supportClasses.ItemRenderer;
	
	[Bindable]
	public class AbstractMonthChooserRenderer extends ItemRenderer
	{
		private var yearVO:YearVO;
		public var yearDisplay:Label;
		public var yearRenderer:YearRenderer;
		
		public function AbstractMonthChooserRenderer()
		{
			super();
		}
		
		
		override public function set data(value:Object):void
		{
			if(value){
				super.data = value;
				yearVO = value as YearVO;
				yearDisplay.text = yearVO.year.toString();
				yearRenderer.fullYear = yearVO.year;
				yearRenderer.monthList = yearVO.monthList;
				yearRenderer.actualYear = yearVO.actualYear == yearVO.year;
				yearRenderer.actualMonth = yearVO.actualMonth;
				yearRenderer.selectedYear = yearVO.selectedYear == yearVO.year;
				yearRenderer.selectedMonth = yearVO.selectedMonth;
				
			}
			
		}
		
		
		
	}
}