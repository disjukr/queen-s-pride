package qp.game.enemy {

    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;

    import qp.game.*;
    import qp.util.MathUtil;

    public class Monster extends MovieClip implements Pausable, ICanDie {

        public static var LIVE: String = 'live';
        public static var DEAD: String = 'dead';

        public var game: Game;
        public var deadSound: String;

        protected var _maxHealth: int;
        protected var _health: int;
        protected var _state: String;

        private var _dx: Number;
        private var _dy: Number;
        private var _dr: Number;

        public function Monster() {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this._state = LIVE;
            this._health = this._maxHealth = 100;
            this.rotation = 0;
            this.alpha = 1;
        }

        // ICanDie
        public function get maxHealth(): int {
            return this._maxHealth;
        }
        public function get health(): int {
            return this._health;
        }
        public function hit(attacker: ICanAttack): void {
            if (this._state != LIVE)
                return;
            this._health -= attacker.damage;
            if (this._health <= 0) {
                this._health = 0;
                this._state = DEAD;
                this._dx = 8 + Math.random() * 5;
                this._dy = -(15 + Math.random() * 5);
                this._dr = (Math.random() - 0.5) * 30;
                this.dispatchEvent(new Event("dead"));
                SoundManager.event(deadSound);
                if (game.dynamicArea) {
                    var boom: Boom = new Boom;
                    boom.x = this.x;
                    boom.y = this.y;
                    game.dynamicArea.addChild(boom);
                }
            }
        }
        public function getHitArea(): DisplayObject {
            return this;
        }

        // Pausable
        public function pause(): void {
            this.stop();
            removeListeners();
        }
        public function resume(): void {
            this.play();
            addListeners();
        }

        private function addListeners(): void {
            this.addEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }
        private function removeListeners(): void {
            this.removeEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }

        protected function move(): void {
            this.x -= 3;
        }

        protected function ENTER_FRAME(e: Event): void {
            if (this.alpha <= 0                        ||
                this.x + this.width < 0                ||
                this.y + this.height > stage.stageHeight)
                this.game.removeMonster(this);
            switch (this._state) {
            case DEAD:
                this._dy += 1.5;
                this.x += this._dx;
                this.y += this._dy;
                this.rotation += this._dr;
                this.alpha -= 0.03;
                break;
            default:
                move();
            }
        }
    }
}
