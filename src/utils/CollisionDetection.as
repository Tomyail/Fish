package utils
{
    import flash.geom.Rectangle;
    public class CollisionDetection
    {
        private var followerSin:Number;
        private var followerCos:Number;
        private var i:int;
        private var ax:Number;
        private var ay:Number;
        private var primeCos:Number;
        private var primeSin:Number;
        private var fx:Number;
        private var fy:Number;
        private var w:Number;
        private var h:Number;
        private var mon:uint;
        /**
         * <p>将跟随矩阵的坐标系转到主矩阵的坐标系然后循环检测是否包含点来实现碰撞检测，其中根据level级别判断需要检测的点数</p>
         * <p>点计算顺序为顺时针按照级数（level）逐级遍历</p>
         * 0 1<br/>
         * 3 2<br/>
         * @param primeRect 主矩阵
         * @param primeRadian 主矩阵旋转角度
         * @param followerRect 跟随矩阵
         * @param followerRadian 跟随矩阵旋转角度
         * @param lelvel 判断跟随矩阵的点的数量（0表示四个顶点，1表示除了四个点之外再加上各个边的中点，判断8个点，3级16个点依次类推
         */
        public function collisionDetect(primeRect:Rectangle,primeRadian:Number,followerRect:Rectangle,followerRadian:Number,lelvel:uint = 0):Boolean{
            followerSin = Math.sin(followerRadian);
            followerCos = Math.cos(followerRadian);
            primeSin = Math.sin(primeRadian);
            primeCos = Math.cos(primeRadian);
            mon = lelvel+1;
//			trace("primeRect",primeRect,"primeRadian",primeRadian,"followerRect",followerRect,"followerRadian",followerRadian,"mon",mon)
            //遍历所有级数对应的点
            for(i = 0;i<= lelvel;i++){
                w = followerRect.width * i / mon;
                h = followerRect.height * i /mon;
                //0点
                calculateFinalXY(w,0,followerRect,primeRect);
                if(primeRect.contains(fx,fy)) return true;
                //1点
                calculateFinalXY(followerRect.width,h,followerRect,primeRect);
                if(primeRect.contains(fx,fy)) return true;
                //2点
                calculateFinalXY(followerRect.width-w,followerRect.height,followerRect,primeRect);
                if(primeRect.contains(fx,fy)) return true;
                //3点
                calculateFinalXY(0,followerRect.height-h,followerRect,primeRect);
                if(primeRect.contains(fx,fy)) return true;
            }
            return false;
        }
        
        /**
         * 根据随矩阵的信息计算其绕主矩阵旋转后的坐标 
         * @param mx
         * @param my
         * @param mRec
         */
        private function calculateFinalXY(mx:Number,my:Number,mRec:Rectangle,pRec:Rectangle):void{
            ax = followerCos * mx - followerSin * my;   //绕自己的原点旋转 after 
            ay = followerCos * my + followerSin * mx;
            ax += mRec.x;                               //加上其矩阵坐标
            ay += mRec.y;
			
			ax -= pRec.x;								//移动到主矩阵所在的坐标系
			ay -= pRec.y;
			
            fx = primeCos * ax + primeSin * ay;         //绕主矩阵<b>反转</b>
            fy = primeCos * ay - primeSin * ax;
			
			fx += pRec.x;
			fy += pRec.y;								//移动到世界坐标系
        }
    }
}