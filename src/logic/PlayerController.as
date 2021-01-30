package logic
{
	import flash.display.Stage;

import game.GameStage;

import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.space.Space;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.events.Event;
	/**
	 * Handles input from physical devices and controlls player character.
	 * @author Joe Harner
	 */
	public class PlayerController 
	{
		private var stage:GameStage;
		private var space:Space;
		private var keymap:Object;
		private var handJoint:PivotJoint;
		private var playerBody:Body;
		
		public var keyboard:Vector.<Boolean>;
		
		public function PlayerController(playerBody:Body, space:Space, gameStage:GameStage)
		{
			this.playerBody = playerBody;
			this.space = space;
			this.stage = gameStage;
			gameStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			gameStage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			gameStage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			gameStage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			gameStage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			keymap = {};
			
			handJoint = new PivotJoint(space.world, null, Vec2.weak(), Vec2.weak());
			handJoint.space = space;
			handJoint.active = false;
			handJoint.stiff = false;
			handJoint.frequency = 1;
			
			
		}
		
		private function mouseDownHandler(ev:MouseEvent):void {
			// Allocate a Vec2 from object pool.
			var mousePoint:Vec2 = Vec2.get(stage.mouseX, stage.mouseY);
			
			// Determine the set of Body's which are intersecting mouse point.
			// And search for any 'dynamic' type Body to begin dragging.
			var bodies:BodyList = space.bodiesUnderPoint(mousePoint);
			for (var i:int = 0; i < bodies.length; i++) {
				var body:Body = bodies.at(i);
				
				if (!body.isDynamic()) {
					continue;
				}
				
				// Configure hand joint to drag this body.
				//   We initialise the anchor point on this body so that
				//   constraint is satisfied.
				//
				//   The second argument of worldPointToLocal means we get back
				//   a 'weak' Vec2 which will be automatically sent back to object
				//   pool when setting the handJoint's anchor2 property.
				handJoint.body2 = body;
				handJoint.anchor2.set(body.worldPointToLocal(mousePoint, true));
				
				// Enable hand joint!
				handJoint.active = true;
				
				break;
			}
			
			// Release Vec2 back to object pool.
			mousePoint.dispose();
		}
		
		private function mouseUpHandler(ev:MouseEvent):void {
			// Disable hand joint (if not already disabled).
			handJoint.active = false;
		}
		
		private function keyDownHandler(ev:KeyboardEvent):void {
			//trace(ev.keyCode);
			if (ev.keyCode == 82) { // 'R'
				// space.clear() removes all bodies and constraints from
				// the Space.
				//space.clear();
				
				//GameStage.instance.setUp();
			}
			
				// Store when the key state
			keymap[ev.keyCode] = true;
			
		}
		
		private function keyUpHandler(ev:KeyboardEvent):void {
			
			keymap[ev.keyCode] = false;
		}
		
		public function isDown(keyCode:int):Boolean {
			return keymap.hasOwnProperty(String(keyCode)) && keymap[keyCode];
		}
		
		public function isUp(keyCode:int):Boolean {
			return !keymap.hasOwnProperty(String(keyCode)) || !keymap[keyCode];
		}
		
		private function enterFrameHandler(ev:Event):void {
			// If the hand joint is active, then set its first anchor to be
			// at the mouse coordinates so that we drag bodies that have
			// have been set as the hand joint's body2.
			if (handJoint.active) {
				handJoint.anchor1.setxy(stage.mouseX, stage.mouseY);
			}
			
			
			if (isDown(Keyboard.A)) { // 'Left'
				playerBody.applyImpulse(new Vec2(-300, 0));
			}
			if (isDown(Keyboard.D)) { // 'Right'
				playerBody.applyImpulse(new Vec2(300, 0));				
			}
			if (isDown(Keyboard.W)) { // 'Up'
				playerBody.applyImpulse(new Vec2(0, -300));
			}
			if (isDown(Keyboard.S)) { // 'Up'
				playerBody.applyImpulse(new Vec2(0, 300));
			}
			
		}
		
	}

}