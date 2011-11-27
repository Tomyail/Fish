package com
{
    public class FishOrder
    {
        private var mainGame:MainGame;
        private var fishKind:int = 0;
        private var fishManager:FishManager;
        
        private const FISH_KIND_MIN:int = 0;
        private const FISH_KIND_MAX:int = 3;
        
        public function FishOrder()
        {
            
        }
        
        public function initialization(game:MainGame,fishManager:FishManager):void{
            this.mainGame = game;
            this.fishManager = fishManager;
        }
        
        public function runOrder():void{
            
        }
    }
}