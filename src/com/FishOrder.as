package com
{
    import data.pools.FishPoolManager;
    
    import demo.FishUnit;
    
    import flash.utils.Dictionary;
    
    import unit.fish.BaseFish;
    
    import utils.Marker;

    public class FishOrder
    {
        private var mainGame:MainGame;
        private var fishKind:int = 0;
        private var fishPoolManager:FishPoolManager;
        
        private const FISH_KIND_MIN:int = 0;
        private const FISH_KIND_MAX:int = 3;
        
        private var dic:Dictionary = new Dictionary();
        private var fishGroup:Vector.<BaseFish> = new Vector.<BaseFish>();
        private var fishLeader:FishUnit;
        private var marker:Marker = new Marker;
        private var markDic:Dictionary;
        private var i:int,j:int,o:Object;
        private var visualFish:int = 0;
        private var fishLeaderAngle:Number;
        private var fishLeaderRadius:Number;
        private var rowIndex:int;
        
        private var data:Vector.<Object> = Vector.<Object>([
            {label:"FishNumber",    v:10, t:"fn", h:changeValue},        //鱼总数
            {label:"FishColumn",    v:2,  t:"fc", h:changeValue},        //鱼列数
            {label:"FishColumnGap", v:20,  t:"fcg",h:changeValue},        //相邻列之间鱼的半径增量
            {label:"CenterX",       v:0,t:"centerX", h:changeValue},   //圆心
            {label:"CenterY",       v:0,t:"centerY", h:changeValue},
            {label:"FirstCurrentX", v:500, t:"currentX",h:changeValue},   //最接近圆心的那列鱼中第一排的初始坐标
            {label:"FirstCurrentY", v:-100,  t:"currentY",h:changeValue},
            {label:"DegreeRate",    v:1,  t:"degreeRate", h:changeValue},//每条鱼的旋转增量
            {label:"DegreeGap",     v:8,  t:"degreeGap", h:changeValue}  //相邻两排鱼之间的角度差
        ]);
        
        private function changeValue():void{
            
        }
        
        public function FishOrder()
        {
            
        }
        
        public function initialization(game:MainGame,fishPoolManager:FishPoolManager):void{
            this.mainGame = game;
            this.fishPoolManager = fishPoolManager;
        }
        
        public function runOrder():void{
            for each (o in data){
                dic[o.t] = o;
            }
            createFishGroup();
        }
        
        
        private function createFishGroup():void{
            fishLeaderAngle = Math.atan2(dic["currentY"].v,dic["currentX"].v)*180/Math.PI;
            fishLeaderRadius = Math.pow(dic["currentX"].v*dic["currentX"].v +dic["currentY"].v*dic["currentY"].v,.5);
//            trace(fishLeaderAngle ,fishLeaderRadius);
            visualFish = 0;
            rowIndex = 0;
            //循环鱼总数
            while(visualFish < dic["fn"].v){
                //循环每行鱼
                for(j = 0;j<dic["fc"].v;j++){
                    if(visualFish >= dic["fn"].v){
                        break;
                    }
                    
                    fishGroup[visualFish] = fishPoolManager.addFishBynName("nimo");
                    
                    fishGroup[visualFish].setFlyData(
                        {
                            centerX:dic["centerX"].v,centerY:dic["centerY"].v,
                            degreeRate:dic["degreeRate"].v,
                            noDegreeX:fishLeaderRadius + j*dic["fcg"].v,//attention
                            noDegreeY:0,                                         
                            currentDegree:fishLeaderAngle - rowIndex * dic["degreeGap"].v * (dic["degreeRate"].v >= 0 ? 1:-1)// / Math.abs(dic["degreeRate"].v)
                        }
                    );
                    fishGroup[visualFish].play();
//                    fishManager.addFish(fishGroup[visualFish]);
//                    marker.addMark(visualFish);
                    //                    trace("visualFish",visualFish,"dic['fn'].v",dic["fn"].v);
                    visualFish ++;
                }
                rowIndex ++;
            }
        }
    }
}