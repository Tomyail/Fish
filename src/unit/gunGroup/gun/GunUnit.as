package unit.gunGroup.gun
{
    
    import starling.display.Sprite;
    import starling.utils.deg2rad;
    import starling.utils.rad2deg;
    
    import unit.gunGroup.fire.FireManager;
    import unit.scorePanel.ScorePanel;

    public class GunUnit extends Sprite
    {
    
        private var gunBody:GunBody = new GunBody;
        private var gunHead:GunHead = new GunHead;
        
        private var mainGame:MainGame;
        private var fireManager:FireManager = new FireManager();
        private var currentRadian:Number;
        public function GunUnit()
        {
        }
        
        public function initialization(mainGame:MainGame):void{
            
            this.mainGame = mainGame;
            fireManager.initialization(mainGame);
            createGun();
            
            mainGame.addChild(this);
            
        }
        
        public function updateFrame():void{
//            trace("mouseX",mainGame.gameData.globalMouseX,"mouseY",mainGame.gameData.globalMouseY)
            //todo 将角度运算写入gameData中避免重复计算
            currentRadian = Math.atan2(mainGame.gameData.globalMouseY - this.y,mainGame.gameData.globalMouseX - this.x)+Math.PI/2;
            gunHead.rotation = currentRadian;
            fireManager.flyMarkedFire();
        }
        /**创建炮台*/
        private function createGun():void
        {
            gunBody.initialization();
            gunHead.initialization();
            addChild(gunBody);
            gunHead.x = gunBody.x + (gunBody.width >>1);
            gunHead.y = gunBody.y +(gunBody.height >>1);
            addChild(gunHead);
            
        }
        
        public function fire(targetX:int,targetY:int):void{
            gunHead.play();
            gunBody.play();
            fireManager.addFire(x,y,gunHead.rotation,targetX,targetY);
        }
        
        public function stop():void{
            gunHead.stop();
            gunBody.stop();
        }
        
        
    }
}