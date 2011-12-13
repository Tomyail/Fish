package utils
{
    import flash.utils.Dictionary;

    /**
     * 用来记录哪些索引被使用和哪些索引未被使用的索引标记器
     * @author tomyail
     */
    public class Marker
    {
        private var _marked:Dictionary;
        private var _unmarked:Dictionary;
        private var _length:int;
        private var preLength:int;
        private var i:int,j:int;
        private var autoIncrease:Boolean;
        private var increaseNumber:int
        
        /**
         * 初始化标记器 
         * @param initialNumber 初始标记器长度
         * @param autoIncrease 当可用标记用完之后是否自增长
         * @param increaseNumber 每次可用标记用完之后的子增长数
         */
        public function Marker(initialNumber:int = 10,autoIncrease:Boolean = false,increaseNumber:int = 10)
        {
            _marked = new Dictionary();
            _unmarked = new Dictionary();
            
            this.autoIncrease = autoIncrease;
            this.increaseNumber = increaseNumber;
            for(i = 0;i< initialNumber;i++){
                _unmarked[i]  = i;
            }
            _length = initialNumber;
        }
        
        
        public function get length():int
        {
            return _length;
        }

        public function get marked():Dictionary
        {
            return _marked;
        }
        
        /** 返回未被使用的标记索引，如果没有可用的标记索引，会根据构造函数传入的参数执行相应的操作*/
        public function getAvailableMarkIndex():int{
            for each (i in _unmarked){
                return i;
            }
            
            if(!autoIncrease){
                throw new Error("no available markIndex");
            }else{
                preLength = _length;
                increaseMarkLength(increaseNumber);
                return preLength;
            }
            return -1;
        }
        
        /** 清空所有被标记过的索引*/
        public function removeAllMark():void{
            for(i = 0;i<_length;i++){
                delete _marked[i];
                _unmarked[i] = i;
            }
        }
        
        
        /**
         * 清空单个被标记过的索引
         */
        public function removeMark(markIndex:int):void{
            if(markIndex < _length){
                delete _marked[markIndex];
                 _unmarked[markIndex] = markIndex;
            }else{
                throw new Error("markIndex is out of range")
            }
        }
        
        /** 标记一个未使用索引为使用索引*/
        public function addMark(markIndex:int):void{
            if(markIndex < _length){
                _marked[markIndex] = markIndex;
                delete _unmarked[markIndex];
            }else{
                if(!autoIncrease){
                    throw new Error("markIndex out of range")
                }else{
                    increaseMarkLength(increaseNumber);
                }
                
            }
        }
        
        private function increaseMarkLength(increaseNumber:int):void
        {
            j = _length + increaseNumber;
            for(i = _length;i<j;i++){
                _unmarked[i] = i;
            }
            _length  = i;
        }
        
        
    }
}