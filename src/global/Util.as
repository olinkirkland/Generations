package global
{
    import com.adobe.utils.DateUtil;

    public class Util
    {
        public static function secondsSince(d:Date):Number
        {
            return Number(((new Date().time - d.time) / 1000).toFixed(4));
        }

        public static function log(v:*):void
        {
            trace(v);
        }

        public static function toArray(iterable:*):Array
        {
            var arr:Array = [];
            for each (var elem:* in iterable)
                arr.push(elem);
            return arr;
        }

        public static function fixed(n:Number, places:int = 2):Number
        {
            return Number(n.toFixed(places));
        }

        public static function capitalizeFirstLetter(str:String):String
        {
            if (str.length == 0)
                return str;

            if (str.length == 1)
                return str.charAt(0).toUpperCase();
            else
                return str.charAt(0).toUpperCase() + str.substr(1);
        }

        public static function colorBetweenColors(color1:uint = 0xFFFFFF, color2:uint = 0x000000, percent:Number = 0.5):uint
        {
            if (percent < 0)
                percent = 0;
            if (percent > 1)
                percent = 1;

            var r:uint = color1 >> 16;
            var g:uint = color1 >> 8 & 0xFF;
            var b:uint = color1 & 0xFF;

            r += ((color2 >> 16) - r) * percent;
            g += ((color2 >> 8 & 0xFF) - g) * percent;
            b += ((color2 & 0xFF) - b) * percent;

            return (r << 16 | g << 8 | b);
        }

        public static function roundToNearest(n:Number, m:Number):Number
        {
            return int(n / m) * m
        }

        public static function toRNDateString(date:Date):String
        {

            // 2020-10-01T18:00:00+02:00

            var str:String = DateUtil.toW3CDTF(date);
            return str;
        }

        public static function fromRNDateString(str:String):Date
        {
            // 2020-10-01T18:00:00+02:00

            var date:Date = DateUtil.parseW3CDTF(str);
            return date;
        }

        public static function toSimpleDateString(date:Date):String
        {
            return DateUtil.getFullMonthName(date).substr(0, 3) + ". " + date.date;
        }

        public static function addZeroToSingleDigitString(str:String):String
        {
            while (str.length < 2)
                str = "0" + str;
            return str;
        }
    }
}