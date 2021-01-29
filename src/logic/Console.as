package logic
{
    import flash.events.Event;
    import flash.events.EventDispatcher;

    import mx.collections.ArrayCollection;

    public class Console extends EventDispatcher
    {
        private static var _instance:Console;

        public static var history:ArrayCollection = new ArrayCollection();

        public function Console()
        {
            if (_instance)
                throw new Error("Singletons can only have one instance");
            _instance = this;
        }

        public static function get instance():Console
        {
            if (!_instance)
                new Console();
            return _instance;
        }

        public function log(str:String):void
        {
            history.addItem(str);
        }
    }
}