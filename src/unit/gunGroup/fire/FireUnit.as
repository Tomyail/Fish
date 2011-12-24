package unit.gunGroup.fire
{
    import com.Proxy;
    
    import event.FireEvent;
    
    import flash.geom.Rectangle;
    
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.textures.Texture;
    
    import unit.gunGroup.gun.GunHead;
    
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
        private var bulletRect:Rectangle;
        private var netRrect:Rectangle;
        
        private var maxBoundLength:Number;
        //please use interface .....
        private var _rangeBound:Rectangle = new Rectangle;
        private var cdm:Proxy;
        public function FireUnit(id:int,cdm:Proxy)
        {
            this.cdm = cdm;
            
            bulletTexture = Texture.fromBitmap(new bulletBmp,false);
            bullet = new Image(bulletTexture);
            
            netFrames = FrameGenerator.generateFrame(new netBmp,XML(new netXml),netName);
            
            net = new MovieClip(netFrames);
            net.pivotX = net.width>>1;
            net.pivotY = net.height>>1;
            net.loop = false;
            this.id = id;
            fireEvent = new  FireEvent(FireEvent.FIRE_OVER,id,true);
            
            bulletRect = new Rectangle(0,0,bullet.width,bullet.height);
            netRrect = new Rectangle(0,0,net.width,net.height);
            maxBoundLength = (bullet.width > bullet.height) ? bullet.width:bullet.height;
            _rangeBound.width = _rangeBound.height = maxBoundLength<<1;
        }
        
        private function burst():void{
            net.y = bullet.y;
            net.x = bullet.x;
            removeChild(bullet);
            addChild(net);
            Starling.juggler.add(net);
            net.play();
            cdm.catchFish(this);
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
        
        public function get bulletBound():Rectangle{
            bulletRect.x = bullet.x;
            bulletRect.y = bullet.y;
            return bulletRect;
        }
        
        public function get rangeBound():Rectangle{
            _rangeBound.x = bullet.x - maxBoundLength;
            _rangeBound.y = bullet.y - maxBoundLength;
            return _rangeBound;
        }
        
        public function get bulletRadian():Number{
            return bullet.rotation;
        }
        
        public function get netBound():Rectangle{
            netRrect.x = net.x;
            netRrect.y = net.y;
            return netRrect;
        }
        
        public function updateFrame():void{
            if(currentStatus ==0){
                //todo碰撞检测
                if(cdm.hitTest(this)){
                    currentStatus = 1;
                    burst()
                }else{
                    bullet.x += (tX - bullet.x)*easing;
                    bullet.y += (tY - bullet.y) * easing;
                    if(Math.abs(tX - bullet.x) < minX && Math.abs(tY - bullet.y) < minY){
                        currentStatus = 1;
                        burst();
                    }
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