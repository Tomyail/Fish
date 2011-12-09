package unit.fire
{
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;
    
    /**
     * 一个fireunit包含一颗子弹和其对应的网 
     * @author tomyail
     * 
     */    
    public class FireUnit extends Sprite
    {
        [Embed(source='../media/shot.png')]
        private static const __bmp:Class;
        [Embed(source="source")]
        private var texture:Texture;
        private var bullet:Image;
        private var 
        public function FireUnit()
        {
            texture = Texture.fromBitmap(new __bmp,false);
            bullet = new Image(texture);
        }
        
    }
}