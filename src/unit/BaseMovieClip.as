package unit
{
    import flash.display.Bitmap;
    
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.textures.Texture;
    
    import utils.FrameGenerator;

    
    public class BaseMovieClip extends Sprite
    {
        protected var fps:int = 7;
        protected var movieClip:MovieClip;
        protected var frames:Vector.<Texture>;
        public function BaseMovieClip()
        {
        }
        
        protected function createMovieclip(bitmap:Bitmap,xml:XML,frameName:String):void{
            frames = FrameGenerator.generateFrame(bitmap,xml,frameName);
            movieClip = new MovieClip(frames,fps);
//            movieClip.pivotX = movieClip.width >>1;
//            movieClip.pivotY = movieClip.height >>1;
        }
        
        protected function changeTexture():void{
//            movieClip.setTextures(frames);
        }
        
        public function clone():MovieClip{
            if(frames != null){
                var cloneMc:MovieClip = new MovieClip(frames,fps);
                cloneMc.pivotX = cloneMc.width >> 1;
                cloneMc.pivotY = cloneMc.height >> 1;
                return cloneMc;
            }
            return null;
        }
        
    }
}