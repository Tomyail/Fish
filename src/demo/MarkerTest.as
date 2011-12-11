package demo
{
    import flash.display.Sprite;
    import flash.utils.*;
    
    import utils.Marker;
    
    public class MarkerTest extends Sprite
    {
        
        public function MarkerTest()
        {
            var marker:Marker = new Marker();
            var dic:Dictionary = marker.marked;
            
            var t:int = getTimer();
            for(var i:int = 0;i<100000;i++){
                marker.addMark(i);
            }
            marker.removeMark(0);
            trace("create time",getTimer()-t)
            
//            for each(var o:Object in dic){
//                marker;
//            }
//            for(i = 5000;i<100000;i++){
//                marker.removeMark(i);
//            }
//            trace(marker.length);
            
            t = getTimer();
            for(i = 0;i<100000;i++){
                dic[i]
            }
            trace("for del time",getTimer()-t)
           t = getTimer();
            for each(i in dic){
                dic[i]
            }
            trace("del time",getTimer()-t);
            
        }
    }
}