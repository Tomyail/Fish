package unit.gunGroup
{
    import com.FishPoolManager;
    
    import unit.gunGroup.fire.FireManager;
    import unit.gunGroup.gun.GunUnit;
    import unit.scorePanel.ScorePanel;

    public class GunGroup
    {
        /**
         * view 
         */    
        //炮台
        private var gunUnit:GunUnit;
        //子弹计数器
        private var scorePannel:ScorePanel;
        

        /**
         * model
         */     
        //子弹管理器
        private var fireManager:FireManager;
        private var cost:int = 10;
        public function GunGroup()
        {
        }
        
        public function initialization(mainGame:MainGame,fishPoolManager:FishPoolManager):void{
            gunUnit = new GunUnit();
            gunUnit.initialization(mainGame);
            mainGame.addChild(gunUnit);
            gunUnit.x = mainGame.stage.stageWidth>>1;
            gunUnit.y = mainGame.stage.stageHeight - gunUnit.height;
            
            scorePannel = new ScorePanel();
            scorePannel.initialization();
            scorePannel.setScore(1000);
            mainGame.addChild(scorePannel);
            scorePannel.x = gunUnit.x+gunUnit.width;
            scorePannel.y = mainGame.stage.stageHeight - scorePannel.height;
            
            fireManager = new FireManager();
            fireManager.initialization(mainGame);
        }
        
        public function addScore(score:int):void{
            scorePannel.addScore(score);
        }
        
        public function updateFrame():void{
            gunUnit.updateFrame();
        }
        
        public function startFire(targetX:Number,targetY:Number):void{
            if(scorePannel.consumeScore(cost)){
                gunUnit.fire(targetX,targetY);
            }
        }
        
        public function stopFire():void{
            gunUnit.stop();
        }
    }
}