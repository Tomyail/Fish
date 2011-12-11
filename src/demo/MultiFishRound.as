package demo
{
    import com.bit101.components.InputText;
    import com.bit101.components.Label;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.Dictionary;
    
    import utils.Marker;
    
    /**
     * 鱼实例化顺序
     * 0 1
     * 2 3
     * ... 
     * @author tomyail
     * 
     */
    public class MultiFishRound extends Sprite
    {
        private var data:Vector.<Object> = Vector.<Object>([
            {label:"FishNumber",    v:10, t:"fn", h:changeValue},        //鱼总数
            {label:"FishColumn",    v:1,  t:"fc", h:changeValue},        //鱼列数
            {label:"FishColumnGap", v:5,  t:"fcg",h:changeValue},        //相邻列之间鱼的半径增量
            {label:"CenterX",       v:110,t:"centerX", h:changeValue},   //圆心
            {label:"CenterY",       v:110,t:"centerY", h:changeValue},
            {label:"FirstCurrentX", v:100, t:"currentX",h:changeValue},   //最接近圆心的那列鱼中第一排的初始坐标
            {label:"FirstCurrentY", v:0,  t:"currentY",h:changeValue},
            {label:"DegreeRate",    v:1,  t:"degreeRate", h:changeValue},//每条鱼的旋转增量
            {label:"DegreeGap",     v:20,  t:"degreeGap", h:changeValue}  //相邻两排鱼之间的角度差
        ]);
        
        private var dic:Dictionary = new Dictionary();
        private var fishGroup:Vector.<FishUnit> = new Vector.<FishUnit>();
        private var fishLeader:FishUnit;
        private var marker:Marker = new Marker;
        private var markDic:Dictionary;
        private var i:int,j:int,o:Object;
        private var visualFish:int = 0;
        private var fishLeaderAngle:Number;
        private var fishLeaderRadius:Number;
        private var rowIndex:int;
        
        public function MultiFishRound()
        {
            createUI();
            initData();
            addEventListener(Event.ENTER_FRAME,updateFrame);
        }
        
        protected function updateFrame(event:Event):void
        {
            markDic = marker.marked;
            for each(o in markDic){
                fishGroup[o].updateFrame();
//                trace(o);
            }
        }
        
        private function initData():void{
            for each (o in data){
                dic[o.t] = o;
            }
            createFishGroup();
        }
        
        private function createFishGroup():void{
            fishLeaderAngle = Math.atan2(dic["currentY"].v,dic["currentX"].v)*180/Math.PI;
            fishLeaderRadius = Math.pow(dic["currentX"].v*dic["currentX"].v +dic["currentY"].v*dic["currentY"].v,.5);
            trace(fishLeaderAngle ,fishLeaderRadius);
            visualFish = 0;
            rowIndex = 0;
            //循环鱼总数
            while(visualFish < dic["fn"].v){
                //循环每行鱼
                for(j = 0;j<dic["fc"].v;j++){
                    if(visualFish >= dic["fn"].v){
                        break;
                    }
                    
                    if(marker.marked[visualFish] == null){
                        fishGroup[visualFish] = new FishUnit();
                    }
                    fishGroup[visualFish].setFlyData(
                        {
                            centerX:dic["centerX"].v,centerY:dic["centerY"].v,
                            degreeRate:dic["degreeRate"].v,
                            noDegreeX:fishLeaderRadius + j*dic["fcg"].v,//attention
                            noDegreeY:0,                                         
                            currentDegree:fishLeaderAngle - rowIndex * dic["degreeGap"].v * dic["degreeRate"].v / Math.abs(dic["degreeRate"].v)
                        }
                    );
                    addChild(fishGroup[visualFish]);
                    marker.addMark(visualFish);
//                    trace("visualFish",visualFish,"dic['fn'].v",dic["fn"].v);
                    visualFish ++;
                }
                rowIndex ++;
            }
        }
        
        /** 创建交互UI*/
        private function createUI():void
        {
            var uiContainer:Sprite = new Sprite();
            i = 0;
            for each (o in data){
                var label:Label = new Label(uiContainer,0,20*i++,o.label);
                var inputText:InputText = new InputText(uiContainer,label.x+70,label.y,o.v,o.h);
                inputText.name = o.t;
            }
            addChild(uiContainer);
            uiContainer.x = 300;
        }
        
        private function changeValue(e:Event):void{
//            marker.removeAllMark();
            for each (i in marker.marked){
                removeChild(fishGroup[i]);
                marker.removeMark(i);
            }
            dic[e.target.name].v = parseInt(e.target.text);
//            trace(e.target.name,dic[e.target.name].v);
            createFishGroup();
        }
    }
}