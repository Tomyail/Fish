package utils
{
    import flash.utils.Dictionary;

    public class Marker
    {
        private var _dic:Dictionary;
        private var maxlength:int;
        private var i:int;
        public function Marker(maxLength:int)
        {
            _dic = new Dictionary;
            this.maxlength = maxLength;
        }
        
        
        public function get dic():Dictionary
        {
            return _dic;
        }

        public function add():int{
            for(i = 0;i< maxlength;i++){
                if(_dic[i] == null){
                    _dic[i] = i;
                    return i;
                }
            }
            return -1;
        }
        
        public function isEmpty(index:int):void{
            if(dic[index] == null)
                return true
            return false;
        }
        
        public function delAll():void{
            for each (i in dic){
                delete dic[i];
            }
        }
        
        
    }
}