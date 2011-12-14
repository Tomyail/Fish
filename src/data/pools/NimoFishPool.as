package data.pools
{
    import unit.fish.NimoFish;
    
    import utils.Marker;

    public class NimoFishPool extends FishPool
    {
        private var i:int;
        public function NimoFishPool()
        {
            super();
        }
        
        override public function initialization(mainGame:MainGame,initNumber:Number, increaseNumber:int):void{
            this.mainGame = mainGame;
            this.fishMarker = new Marker(initNumber,true,increaseNumber);
            this.fishVector = new Vector.<NimoFish>;
            for(i = 0;i<initNumber;i++){
                fishVector[i] = new NimoFish();
                fishVector[i].initialization(mainGame,i);
            }
        }
    }
}