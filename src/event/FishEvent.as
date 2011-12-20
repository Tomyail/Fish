package event
{
    import starling.events.Event;
    
    public class FishEvent extends Event
    {
        public var id:int;
        public var name:String;
        public static const FISH_DIE_COMPLETE:String = "fishDieComplete"
        public function FishEvent(type:String,id:int,name:String, bubbles:Boolean=false)
        {
            this.id = id;
            this.name = name;
            super(type, bubbles);
        }
    }
}