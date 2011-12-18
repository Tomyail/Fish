package unit.fire
{
    import event.FireEvent;
    
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.textures.Texture;
    
    import unit.gun.GunHead;
    
    import utils.FrameGenerator;
    
    /**
     * 一个fireunit包含一颗子弹和其对应的网 
     * @author tomyail
     * 
     */    
    public class FireUnit extends Sprite
    {
        [Embed(source='../media/textures/mc/shot.png')]
        private static const bulletBmp:Class;
        private var bulletTexture:Texture;
        private var bullet:Image;
//        
        [Embed(source='../media/textures/mc/nets.png')]
        private static const netBmp:Class;
        [Embed(source="../media/textures/mc/nets.xml", mimeType="application/octet-stream")]
        private static const netXml:Class;
        private static const netName:String = "nets"
        private const easing:Number = .5;
        private const minX:int = 5;
        private const minY:int = 5;
//        
//        
        private var net:MovieClip;
        
        private var tX:Number = 0;
        private var tY:Number = 0;
        
        private var id:int;
        private var fireEvent:FireEvent;
        //0:子弹状态 1:网开始展开状态 2:网完全张开状态
        private var currentStatus:int = 0;	
        private var netFrames:Vector.<Texture>;
        
        public function FireUnit(id:int)
        {
            bulletTexture = Texture.fromBitmap(new bulletBmp,false);
            bullet = new Image(bulletTexture);
            
            netFrames = FrameGenerator.generateFrame(new netBmp,XML(new netXml),netName);
            
            net = new MovieClip(netFrames);
            net.pivotX = net.width>>1;
            net.pivotY = net.height>>1;
            net.loop = false;
            this.id = id;
            fireEvent = new  FireEvent(FireEvent.FIRE_OVER,id,true);
        }
        
        private function burst():void{
            net.y = bullet.y;
            net.x = bullet.x;
            removeChild(bullet);
            addChild(net);
            Starling.juggler.add(net);
            net.play();
        }
        
        private function addBullet():void{
            removeChild(net);
            addChild(bullet);
            currentStatus = 0;
        }
        
        public function fireOver():void{
            Starling.juggler.remove(net);
            net.stop();
            dispatchEvent(fireEvent);
        }
        
        public function setTarget(birthX:Number,birthY:Number,rotation:Number,tX:Number,tY:Number):void{
            
            this.tX = tX;
            this.tY = tY;
            bullet.x = birthX;
            bullet.y = birthY;
            //计算角度
            bullet.rotation =rotation;
            //计算初始坐标
            addBullet();
        }
        
        
        public function updateFrame():void{
            if(currentStatus ==0){
                //todo碰撞检测
                bullet.x += (tX - bullet.x)*easing;
                bullet.y += (tY - bullet.y) * easing;
                if(Math.abs(tX - bullet.x) < minX && Math.abs(tY - bullet.y) < minY){
                    currentStatus = 1;
                    burst();
                }
            }
            
            else if(currentStatus == 1){
                if(net.currentFrame+1 == net.numFrames){
                    fireOver();
                }
            }
        }
    }
}