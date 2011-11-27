package unit.gun
{
    
    import starling.display.Sprite;
    import starling.utils.deg2rad;
    import starling.utils.rad2deg;

    public class Gun extends Sprite
    {
    
        private var gunbody:GunBody = new GunBody;
        private var gunHead:GunHead = new GunHead;
        
        private var mainGame:MainGame
        public function Gun()
        {
        }
        
        public function initialization(mainGame:MainGame):void{
            
            this.mainGame = mainGame;
            
            createGun();
            
            mainGame.addChild(this);
            this.x = mainGame.stage.stageWidth >> 1;
            this.y = stage.stageHeight - (gunHead.height >>1);
            
        }
        
        public function updateFrame():void{
            gunHead.rotation = Math.atan2(mainGame.gameData.globalMouseY - this.y,mainGame.gameData.globalMouseX - this.x)+Math.PI/2;
        }
        /**创建炮台*/
        private function createGun():void
        {
            gunbody.initialization();
            gunHead.initialization();
            addChild(gunbody);
            addChild(gunHead);
            
        }
        
        public function fire():void{
            gunHead.play();
            gunbody.play();
        }
        
        public function stop():void{
            gunHead.stop();
            gunbody.stop();
        }
        
    }
}