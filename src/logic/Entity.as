package logic
{
    import flash.display.MovieClip;

    import global.Color;

    import nape.geom.Vec2;
    import nape.phys.Body;
    import nape.phys.BodyType;

    public class Entity
    {
        public var id:String;

        public var x:Number;
        public var y:Number;

        // dynamic, kinematic, static
        public var bodyType:String;
        public var rotation:Number;

        public var clip:MovieClip;

        // Nape body
        public var body:Body;

        public function Entity()
        {
        }

        public static function fromUntyped(v:Object):Entity
        {
            var t:Entity = new Entity();
            t.body = new Body(BodyType[v.bodyType], new Vec2(v.x, v.y));
            t.updateFromUntyped(v);

            t.clip = new MovieClip();
            t.clip.graphics.beginFill(Color.stringToLightColor(t.id));
            t.clip.graphics.drawCircle(0, 0, 20);
            t.clip.graphics.endFill();

            return t;
        }

        public function toUntyped():Object
        {
            return {id: id, x: body.position.x, y: body.position.y, bodyType: body.type.toString(), rotation: body.rotation};
        }

        public function updateFromUntyped(v:Object):void
        {
            id = v.id;
            x = v.x;
            y = v.y;
            bodyType = v.bodyType != null ? v.bodyType : "STATIC";
            rotation = v.rotation != null ? v.rotation : 0;
        }
    }
}
