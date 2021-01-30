package events
{
    public class GameEvent extends PayloadEvent
    {
        public static var USER_CHANGED:String = "userChanged";

        public function GameEvent(type:String, payload:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            this.payload = payload;
        }
    }
}
