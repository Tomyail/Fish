package com
{

    public class FishFacatory
    {
        private var mainGame:MainGame;
        private var lastActiveTime:int;
        private const ORDER_INTERNAL:int = 10000;
        private var fishOrder:FishOrder = new FishOrder();
        public var fishPoolManager:FishPoolManager = new FishPoolManager();
        public function FishFacatory()
        {
        }
        public function initialization(game:MainGame):void{
            this.mainGame = game;
            fishPoolManager.initialization(mainGame);
            fishOrder.initialization(mainGame,fishPoolManager);
            fishOrder.runOrder();
        }
        public function updateFrame():void{
            fishPoolManager.updateFrame();
            if(mainGame.gameData.currentWeight < mainGame.gameData.MAX_WEIGHT){
                fishOrder.runOrder();
            }
        }
        
    }
}