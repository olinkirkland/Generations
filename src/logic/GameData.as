package logic
{
    import flash.events.EventDispatcher;

    public class GameData extends EventDispatcher
    {
        private static var _instance:GameData;

        private var playersById:Object = {};

        public var myId:int;

        public function GameData()
        {
            if (_instance)
                throw new Error("Singletons can only have one instance");
            _instance = this;
        }

        public static function get instance():GameData
        {
            if (!_instance)
                new GameData();
            return _instance;
        }

        public function addPlayer(id:int, name:String):void
        {
            var p:Player = new Player();
            p.id = id;
            p.name = name;
            playersById[id] = p;
        }

        public function removePlayer(id:int):void
        {
            playersById[id] = null;
        }

        public function getPlayer(id:int):Player
        {
            return playersById[id];
        }
    }
}