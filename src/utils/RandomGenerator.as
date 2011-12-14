package utils
{
    public class RandomGenerator
    {
        public function RandomGenerator()
        {
        }
        
        private static var source:Array;
        private static var i:int;
        /**包括两侧*/
        public static function getIntFromRange(min:int,max:int,step:int = 1):int{
            source.length = 0;
            for(i = min,i<=max;i+=step){
                source.push(i);
            }
            return parseInt(getObjectFromSource(source));
        }
        
        public static function getObjectFromSource(source:Array):Object{
            return source[Math.random()*source.length]
        }
    }
}