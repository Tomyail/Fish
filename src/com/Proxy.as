package com
{
    import unit.gunGroup.GunGroup;
    import unit.gunGroup.fire.FireUnit;
    

    public class Proxy
    {
        private var fishPoolManager:FishPoolManager;
        private var gunGroup:GunGroup;
        public function Proxy()
        {
        }
        
        public function initialization(fishPoolManager:FishPoolManager,gunGroup:GunGroup):void{
            this.fishPoolManager = fishPoolManager;
            this.gunGroup = gunGroup;
        }
        
        public function hitTest(fireUnit:FireUnit):Boolean{
            return fishPoolManager.hitTest(fireUnit.rangeBound,fireUnit.bulletBound,fireUnit.bulletRadian);
        }
        
        public function catchFish(fireUnit:FireUnit):void{
            fishPoolManager.catchFish(fireUnit.netBound);
        }
        
        public function addScore(score:int):void{
            gunGroup.addScore(score);
        }
    }
}