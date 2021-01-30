package logic
{
    import events.GameEvent;

    import flash.events.EventDispatcher;

    import mx.utils.UIDUtil;

    public class GameData extends EventDispatcher
    {
        private static var _instance:GameData;

        public var myId:int;

        private var playersById:Object = {};

        private var entitiesById:Object = {};

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

        public function reset():void
        {
            myId = -1;
            playersById = {};
            entitiesById = {};
        }

        public function createGameState():String
        {
            /**
             * Generate map geometry and return it as a json
             * Map geometry consists of physics objects and related sprites
             * Some physics objects can be pushed around, others cannot be passed through
             *
             * The object created here is not the actual physics objects,
             * it is instructions to be passed to the server and broadcast
             */

            var a:Array = [];

            // Add four walls to keep players from leaving the map
            // Top wall
//            a.push({});
            // Left wall
//            a.push({});
            // Right wall
//            a.push({});
            // Bottom wall
//            a.push({});

            // Add some boxes to move around
            for (var i:int = 0; i < 3; i++)
                a.push({x: int(Math.random() * 1000), y: int(Math.random() * 600), bodyType: "KINETIC"});

            var v:Object = {};
            for each (var entity:Object in a)
            {
                entity.id = UIDUtil.createUID();
                v[entity.id] = entity;
            }

            return JSON.stringify(v);
        }

        public function getGameState():String
        {
            var v:Object = {};

            // Entities
            for each (var t:Entity in entitiesById)
                v[t.id] = t.toUntyped();

            return JSON.stringify(v);
        }

        public function setGameState(json:String):void
        {
            Console.instance.log(json);
            var v:Object = JSON.parse(json);

            // Entities
            for each (var untypedEntity:Object in v)
            {
                if (!entitiesById.hasOwnProperty(untypedEntity.id))
                    entitiesById[untypedEntity.id] = Entity.fromUntyped(untypedEntity);
                else
                    (entitiesById[untypedEntity.id] as Entity).updateFromUntyped(untypedEntity);
            }

            Signal.instance.dispatchEvent(new GameEvent(GameEvent.GAME_STATE_UPDATE));
        }

        public function get entities():Array
        {
            var a:Array = [];
            for each (var t:Entity in entitiesById)
                a.push(t);

            return a;
        }
    }
}