package demo
{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    
    public class Bullet extends Sprite
    {
        private const WIDTH:int = 30;
        private const HEIGHT:int = 60;
        
        private var bullet:Shape = new Shape;
        private var rect:Rectangle = new Rectangle();
        private var bulletRotation:Number= 0;
        public function Bullet()
        {
            bullet.graphics.beginFill(0x0000ff);
            bullet.graphics.drawRect(0,0,WIDTH,HEIGHT);
            addChild(bullet);
            rect.width = WIDTH;
            rect.height = HEIGHT;
        }
        
        public function get radian():Number{
            return bulletRotation * Math.PI /180;
        }
        
        public function get unrotatedRect():Rectangle
        {
            return rect;
        }
        
        public function setXY(x:Number,y:Number):void{
            rect.x = x;
            rect.y = y;
            bullet.x = rect.x;
            bullet.y = rect.y;
        }
        
        public function setRotation(rotation:Number):void{
            bulletRotation = rotation
            bullet.rotation = bulletRotation;
        }
    }
}