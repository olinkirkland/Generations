package ui
{
    import global.Util;

    public class RNMeta
    {
        public var name:String = "";
        public var gameWorlds:Array = [];
        public var startDate:Date = new Date();
        public var endDate:Date = new Date();
        public var url:String = "";
        public var tags:Array = [];
        public var otoTags:Array = [];

        public function RNMeta()
        {
        }

        public function toObject():Object
        {
            var json:Object = {
                name:       name,
                gameWorlds: gameWorlds,
                startDate:  Util.toRNDateString(startDate), // 2020-10-01T18:00:00+02:00
                endDate:    Util.toRNDateString(endDate), // 2020-10-01T18:00:00+02:00
                url:        url,
                tags:       tags,
                otoTags:    otoTags
            }

            return json;
        }
    }
}
