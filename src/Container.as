package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display3D.textures.Texture;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author David
	 */
	[Embed(source="../assets/circle.swf", symbol="Container")]
	public class Container extends Sprite
	{
		public var circle:Sprite;
		private var main:Sprite;
		private var bar:Shape;
		private var robot1:Shape;
		private var conteneur1:Shape;
		private var conteneur2:Shape;
		private var robot1Text:TextField;
		private var conteneur1Text:TextField;
		private var conteneur2Text:TextField;
		private var robot1Charge:int;
		private var conteneur1Contenu:int;
		private var conteneur2Contenu:int;
		private var timer:Timer;
		private var timer2:Timer;
		private var timer3:Timer;
		private var timer4:Timer;
		private var surcharge:Boolean;
		
		public function Container(main:Sprite) 
		{
			this.main = main;
			robot1Charge = 10;
			conteneur1Contenu = 0;
			
			circle.x = 300;
			circle.y = 300;
			circle.width = 100;
			circle.height = 100;
			circle.addEventListener(MouseEvent.CLICK, clicked);
			
			var barUnder:Shape = new Shape;
			barUnder.graphics.beginFill(0x0F0F0F);
			barUnder.graphics.drawRect(0, 0, 26, -140);
			barUnder.graphics.endFill();
			barUnder.x = 17;
			barUnder.y = 503;
			addChild(barUnder);
			
			bar = new Shape;
			bar.graphics.beginFill(0x00FF00);
			bar.graphics.drawRect(0,0, 20, -1);
			bar.graphics.endFill();
			bar.x = 20;
			bar.y = 500;
			addChild(bar);
			
			robot1Text = new TextField();
			robot1Text.text = robot1Charge.toString();
			robot1Text.x = 340;
			robot1Text.y = 280;
			robot1Text.height = 20;
			robot1Text.width = 20;
			addChild(robot1Text);
			
			conteneur1 = new Shape;
			conteneur1.graphics.beginFill(0x000000);
			conteneur1.graphics.drawRect(0, 0, 50, 50);
			conteneur1.graphics.endFill();
			conteneur1.x = 200;
			conteneur1.y = 380;
			addChild(conteneur1);
			
			conteneur2 = new Shape;
			conteneur2.graphics.beginFill(0x000000);
			conteneur2.graphics.drawRect(0, 0, 50, 50);
			conteneur2.graphics.endFill();
			conteneur2.x = 430;
			conteneur2.y = 380;
			addChild(conteneur2);
			
			conteneur1Text = new TextField();
			conteneur1Text.x = 220;
			conteneur1Text.y = 395;
			conteneur1Text.textColor = 0xffffff;
			conteneur1Text.text = conteneur1Contenu.toString();
			addChild(conteneur1Text);
			
			conteneur2Text = new TextField();
			conteneur2Text.x = 450;
			conteneur2Text.y = 395;
			conteneur2Text.textColor = 0xffffff;
			conteneur2Text.text = conteneur2Contenu.toString();
			addChild(conteneur2Text);
			
			timer = new Timer(5);
			timer.addEventListener(TimerEvent.TIMER, consume);
			timer.addEventListener(TimerEvent.TIMER, afficherTexte);
			main.stage.addEventListener(KeyboardEvent.KEY_DOWN, charge);
			timer.start();
			
			
			timer2 = new Timer(100);
			timer2.addEventListener(TimerEvent.TIMER, robotActions);
			timer2.start();
			
			timer3 = new Timer(2000);
			timer3.addEventListener(TimerEvent.TIMER, newCreature);
			timer3.start();
			
			timer4 = new Timer(1000);
			timer4.addEventListener(TimerEvent.TIMER, actionFinished);
			
		}
		
		private function consume(e:TimerEvent):void 
		{
			if (bar.height > 0) {
				bar.height = bar.height - 1;
				
			}
			else {
				surcharge = false;
				var ct1:ColorTransform = new ColorTransform();
				ct1.color = 0x00FF00;
				bar.transform.colorTransform = ct1;
			}
			
		}
		
		private function charge(e:KeyboardEvent): void {
			if (e.keyCode == 32 && bar.height < 100 && surcharge == false) {
					bar.height = bar.height + 40;
			}
			else if (bar.height > 100) {
				surcharge = true;
				bar.height = 120;
				var ct1:ColorTransform = new ColorTransform();
				ct1.color = 0xFF0000;
				bar.transform.colorTransform = ct1;
			}
		}
		
		private function afficherTexte(e:TimerEvent): void {
			robot1Text.text = robot1Charge.toString();
			conteneur1Text.text = conteneur1Contenu.toString();
			conteneur2Text.text = conteneur2Contenu.toString();
		}
		
		private function robotActions(e:TimerEvent): void {
			if(robot1Charge >0 && conteneur1Contenu > 0 && timer4.running == false && bar.height > 0 && surcharge == false ){
				robot1Charge -= 1;
				conteneur1Contenu -= 1;
				timer4.start();
			}
		}
		
		private function clicked(e:MouseEvent): void {
				robot1Charge = 10;
		}
		
		private function newCreature(e:TimerEvent): void {
			conteneur1Contenu += 1;
			timer4.stop();
		}
		
		private function actionFinished(e:TimerEvent):void {
			conteneur2Contenu += 1;
		}
	}

}