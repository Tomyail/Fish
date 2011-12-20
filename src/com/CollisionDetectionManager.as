package com
{
    import unit.fire.FireUnit;
    

    public class CollisionDetectionManager
    {
        private var fishPoolManager:FishPoolManager;
        public function CollisionDetectionManager()
        {
        }
        
        public function initialization(fishPoolManager:FishPoolManager):void{
            this.fishPoolManager = fishPoolManager;
        }
        
        public function hitTest(fireUnit:FireUnit):Boolean{
            return fishPoolManager.hitTest(fireUnit.rangeBound,fireUnit.bulletBound,fireUnit.bulletRadian);
        }
        
        public function catchFish(fireUnit:FireUnit):void{
            fishPoolManager.catchFish(fireUnit.netBound);
        }
    }
}