package com
{
    public class FishFacatory
    {
        private var mainGame:MainGame;
        private var lastActiveTime:int;
        private const ORDER_INTERNAL:int = 10000;
        private var fishOrder:FishOrder = new FishOrder();
        private var fishManager:FishManager = new FishManager();
        public function FishFacatory()
        {
        }
        public function initialization(game:MainGame):void{
            this.mainGame = game;
            fishManager.initialization(mainGame);
            fishOrder.initialization(mainGame,fishManager);
        }
        public function updateFrame():void{
            if(mainGame.gameData.nowTime - lastActiveTime > ORDER_INTERNAL){
                fishOrder.runOrder();
            }
        }
        
    }
}