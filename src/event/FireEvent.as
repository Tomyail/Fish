package event
{
	import flash.utils.Dictionary;
	
	import starling.events.Event;
	
	public class FireEvent extends Event
	{
		public static const FIRE_OVER:String = "fireOver";
		public var id:int;
        public var caughtFish:Dictionary = new Dictionary(true);
		public function FireEvent(type:String, id:int,bubbles:Boolean=false)
		{
			this.id = id;
			super(type, bubbles);
		}
	}
}