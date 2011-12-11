package com
{
    import unit.fish.BaseFish;
    
    import utils.Marker;

    public class FishManager
    {
        private const MAX_FISH_NUMBER:int = 500;
        public function FishManager()
        {
            hashDic = new Marker(MAX_FISH_NUMBER);
            fishVec = new Vector.<BaseFish>(MAX_FISH_NUMBER,true);
        }
        
        private var mainGame:MainGame;
        private var hashDic:Marker;
        private var fishVec:Vector.<BaseFish>;
        
        private var i:int;
        public function initialization(game:MainGame):void{
            this.mainGame = game;
        }
        
        public function updateFrame():void{
            for each (i in hashDic.dic){
                fishVec[i].fly();
            }
        }
    }
}