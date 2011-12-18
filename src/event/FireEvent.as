package event
{
	import starling.events.Event;
	
	public class FireEvent extends Event
	{
		public static const FIRE_OVER:String = "fireOver";
		public var id:int;
		public function FireEvent(type:String, id:int,bubbles:Boolean=false)
		{
			this.id = id;
			super(type, bubbles);
		}
	}
}