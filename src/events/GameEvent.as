package events
{
    public class GameEvent extends PayloadEvent
    {
        public static const USER_CHANGED:String = "userChanged";
        public static const GAME_STATE_UPDATE:String = "gameStateUpdate";

        public function GameEvent(type:String, payload:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            this.payload = payload;
        }
    }
}
