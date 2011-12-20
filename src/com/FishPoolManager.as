package com
{
    import data.pools.NimoFishPool;
    
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    
    import unit.fish.BaseFish;

    public class FishPoolManager
    {
        private var nimoFishPool:NimoFishPool = new NimoFishPool();
        
        private const NIMO_FISH_NUM:int = 200;
        private const INCREASE_FISH:int = 20;
        
        private var nimoMark:Dictionary;
        public function FishPoolManager()
        {
        }
        
        public function initialization(mainGame:MainGame):void{
            nimoFishPool.initialization(mainGame,NIMO_FISH_NUM,INCREASE_FISH);
        }
        
        public function addFishBynName(name:String):BaseFish{
            switch(name){
                case "nimo":
                    return nimoFishPool.addFish();
            }
            return null;
        }
        
        public function hitTest(rangeRect:Rectangle,rect:Rectangle,radian:Number):Boolean{
            return nimoFishPool.hitTest(rangeRect,rect,radian);
        }
        
        public function updateFrame():void{
            nimoFishPool.flyMarkedFish();
        }
        
    }
}