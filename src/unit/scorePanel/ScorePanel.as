package unit.scorePanel
{
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.HAlign;
    
    public class ScorePanel extends Sprite
    {
        [Embed(source='../media/textures/mc/scoreBg.png')]
        private static const bgBmp:Class;
        private var availableScore:TextField;
        private var curScore:int = 0;
        private var bg:Image;
        
        public function ScorePanel()
        {
            super();
        }
        
        public function initialization():void{
            bg = new Image(Texture.fromBitmap(new bgBmp,false));
            availableScore = new TextField(bg.width,bg.height,"999999","Verdanan",20,0xff0000);
//            availableScore.border = true;
            availableScore.hAlign = HAlign.LEFT;
            availableScore.x = 20;
            addChild(bg);
            addChild(availableScore);
        }
        
        public function setScore(value:int):void{
            curScore = value;
            availableScore.text = curScore.toString();
        }
        
        public function consumeScore(cost:int):Boolean{
            if(curScore - cost > 0){
                curScore -= cost;
                availableScore.text = curScore.toString();
                return true
            }
            return false;
        }
        
        public function addScore(increaseScore:int):void{
            curScore += increaseScore;
            availableScore.text = curScore.toString();
        }
    }
}