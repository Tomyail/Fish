package unit.gunGroup.fire
{
    import event.FireEvent;
    
    import starling.display.Sprite;
    import starling.events.EventDispatcher;
    
    import unit.gunGroup.gun.GunHead;
    
    import utils.Marker;
    
    public class FireManager extends EventDispatcher
    {
        protected var fireMarker:Marker;
        protected var fireVec:Vector.<FireUnit>;
        protected var mainGame:MainGame
        private var index:int;
        private var fire:FireUnit;
		private var fireGroup:Sprite;
        private const initFireBuff:int = 50;
        private var i:int;
        public function FireManager()
        {
        }
        
        public function initialization(mainGame:MainGame):void{
            this.mainGame = mainGame;
            fireMarker = new Marker(initFireBuff,false);
            fireVec = new Vector.<FireUnit>;
            fireGroup = new Sprite();
            mainGame.addChild(fireGroup);
            
            fireGroup.addEventListener(FireEvent.FIRE_OVER,killFire);
            for(i = 0;i<initFireBuff;i++){
                fireVec[i] = new FireUnit(i,mainGame.cdm);
            }
        }
        
        //移除一颗没速度的子弹
        private function killFire(e:FireEvent):void
        {
            fireMarker.removeMark(e.id);
            fireGroup.removeChild(fireVec[e.id]);
        }
        
        public function addFire(birthX:Number,birthY:Number,rotation:Number,targetX:Number,targetY:Number):void{
            index = fireMarker.getAvailableMarkIndex();
            fireMarker.addMark(index);
            fire = fireVec[index];
            fireGroup.addChild(fire);
            fire.setTarget(birthX,birthY,rotation,targetX,targetY);
        }
        
        public function flyMarkedFire():void{
            for each (index in fireMarker.marked){
                fireVec[index].updateFrame();
            }
        }
    }
}