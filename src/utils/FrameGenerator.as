package utils
{
    import flash.display.Bitmap;
    
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class FrameGenerator
    {
        public function FrameGenerator()
        {
        }
        
        public static function generateFrame(bitmap:Bitmap,xml:XML,frameName:String):Vector.<Texture>{
            var texture:Texture = Texture.fromBitmap(bitmap);
            var textureAtlas:TextureAtlas = new TextureAtlas(texture,xml);
            return textureAtlas.getTextures(frameName);
        }
    }
}