package utils
{
    import flash.utils.Dictionary;

    public class Marker
    {
        private var _marked:Dictionary;
        private var _unmarked:Dictionary;
        private var _length:int;
        private var i:int;
        public function Marker(weakKeys:Boolean = false)
        {
            _marked = new Dictionary(weakKeys);
            _unmarked = new Dictionary(weakKeys);
        }
        
        
        public function get length():int
        {
            return _length+1;
        }

        public function get marked():Dictionary
        {
            return _marked;
        }
        
        public function addMark(markIndex:int):void{
            _marked[markIndex] = markIndex;
            if(markIndex > _length) _length = markIndex;
        }
        
        //(考虑性能暂时不用，所以没写)注意如果返回没有可用标记，外部对次类的length引用需要更新
        public function getAvailableMarkIndex():int{
            for each (i in _unmarked){
                return i;
            }
            _length ++;
            _marked[_length] = _length;
            trace("no avalable")
            return _length+1;
        }
        
        public function removeAllMark():void{
            for each (i in _marked){
                delete _marked[i];
            }
        }
        
        public function removeMark(markIndex:int):void{
            delete _marked[markIndex];
//            _dic[markIndex] = null;
        }
        
    }
}