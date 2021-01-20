package global
{
    public class Color
    {
        // Shades
        public static const white:uint = 0xffffff;
        public static const grey:uint  = 0xcccccc;
        public static const black:uint = 0x000000;

        // UI
        public static const callout:uint = 0x0097e6;
        public static const primary:uint = 0x7f8fa6;

        public static const background:uint = 0xffffff;
        public static const foreground:uint = 0xf4f5fb;

        public static const darkBody:uint  = 0x5f656d;
        public static const lightBody:uint = 0xFFFFFF;

        public static function stringToColor(str:String):uint
        {
            var modifier:int = 1;
            var seed:int     = 11;
            for (var i:int = 0; i < str.length; i++)
            {
                seed = str.charCodeAt(i) + ((seed << 5) - seed);
                seed = seed & seed;
            }

            seed += modifier;

            var max:Number = 1 / 2147483647;
            var min:Number = -max;
            // Deal with zeroes
            if (seed < 1)
                seed *= 9999;
            // Deal with negatives
            if (seed < 1)
                seed = 1;

            seed ^= (seed << 21);
            seed ^= (seed >>> 35);
            seed ^= (seed << 4);

            return 0xffffff * seed * (seed > 0 ? max : min);
        }

        public static function stringToLightColor(str:String):uint
        {
            var color:uint = stringToColor(str);
            while (!isLight(color))
                color = lighten(color);
            return color;
        }

        public static function lighten(color:uint, modifier:Number = .2):uint
        {
            var z:uint = 0xff * modifier;

            var r:uint = trim(((color & 0xff0000) >> 16) + z);
            var g:uint = trim(((color & 0x00ff00) >> 8) + z);
            var b:uint = trim(((color & 0x0000ff)) + z);

            return r << 16 | g << 8 | b;
        }

        private static function trim(value:uint):uint
        {
            return Math.min(Math.max(0x00, value), 0xff);
        }

        public static function isLight(color:uint):Boolean
        {
            var rgb:Object = hexToRgb(color);
            var a:Number   = (rgb.r * 0.299) + (rgb.g * 0.587) + (rgb.b * 0.114);
            return a > 186;
        }

        public static function hexToRgb(hex:uint):Object
        {
            return {
                r: (hex & 0xff0000) >> 16,
                g: (hex & 0x00ff00) >> 8,
                b: (hex & 0x0000ff)
            };
        }
    }
}
