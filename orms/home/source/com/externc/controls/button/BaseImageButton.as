package  com.externc.controls.button
{
	import com.hydrotik.queueloader.QueueLoader;
	import com.hydrotik.queueloader.QueueLoaderEvent;
	import flash.display.SimpleButton;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Bongs
	 */
	public class BaseImageButton extends SimpleButton
	{
		private var _qLoader:QueueLoader;
		private var _isRight:Boolean;
		private var _isVerticalCenter:Boolean;
		private var _isHorizontalCenter:Boolean;
		public function BaseImageButton(upURL:String, overURL:String="", downURL:String="", hitTestURL:String="") 
		{
			_qLoader = new QueueLoader(true);
			_qLoader.addEventListener(QueueLoaderEvent.ITEM_ERROR, onQueueError, false, 0, true);
			_qLoader.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, onQueueComplete, false, 0, true);
			_qLoader.addEventListener(QueueLoaderEvent.QUEUE_COMPLETE, onQueueAllComplete, false, 0, true);
			
			if(upURL != "")
				_qLoader.addItem(upURL, null, { state:"upState" } );
			if(overURL != "")
				_qLoader.addItem(overURL, null, { state:"overState" } );
			if(downURL != "")	
				_qLoader.addItem(downURL, null, { state:"downState"} );
			if(hitTestURL != "")	
				_qLoader.addItem(hitTestURL, null, { state:"hitTestState"} );
				
			_qLoader.execute();
			
		}
		
		protected function onQueueComplete(event:QueueLoaderEvent):void 
		{
			this[event.info.state] = event.content;
		}
		
		protected function onQueueAllComplete(event:QueueLoaderEvent):void 
		{ 
			if (this.overState == null) 
				this.overState = this.upState;
			if (this.downState == null) 
				this.downState = this.upState;
			if (this.hitTestState == null) 
				this.hitTestState = this.upState;
			
			if(_isVerticalCenter)
				this.y -= this.height / 2;
			if (_isHorizontalCenter)
				this.x -= this.width / 2; 
				
			this.visible = true;	
			dispatchEvent(new Event(Event.COMPLETE));
			
			try {
				_qLoader.dispose();
			}catch(e:*){}
			
		}
		
		protected function onQueueError(event:QueueLoaderEvent):void 
		{
			trace("onQueueError: " + event.message);
		}
		
		public function set isVerticalCenter(value:Boolean):void {
			_isVerticalCenter = value;
		}
		
		public function get isVerticalCenter():Boolean {
			return _isVerticalCenter;
		}
		
		public function set isHorizontalCenter(value:Boolean):void {
			_isHorizontalCenter = value;
		}
		
		public function get isHorizontalCenter():Boolean {
			return _isHorizontalCenter;
		}
		
	}
	
}