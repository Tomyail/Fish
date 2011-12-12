package demo
{
    import flash.display.Sprite;
    import flash.utils.getTimer;
    
    public class SinSpeedVSNumberSpeed extends Sprite
    {
        public function SinSpeedVSNumberSpeed()
        {
            super();
            sintest();
            numberTest();
        }
        
        private function numberTest():void
        {
            // TODO Auto Generated method stub
            var t:int = getTimer();
            for(var i:int = 0;i<100000;i++){
                Math.sin(.243234*i);
            }
            trace(getTimer()-t);
        }
        
        private function sintest():void
        {
            // TODO Auto Generated method stub
            
        }
    }
}