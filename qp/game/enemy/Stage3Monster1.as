package qp.game.enemy {

    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;

    import qp.game.*;
    import qp.util.MathUtil;

    public class Stage3Monster1 extends MovieClip implements Pausable, ICanDie, ICanAttack {

        private static var DEFAULT_MAX_HEALTH: int = 100;
        private static var DEFAULT_HEALTH: int = 100;

        public var game: Game;

        private var _t: Number;
        private var _health: int;
        private var _targets: Vector.<ICanDie>;

        public function Stage3Monster1() {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this._health = DEFAULT_HEALTH;
            this._t = 0;
        }

        // ICanDie
        public function get maxHealth(): int {
            return DEFAULT_MAX_HEALTH;
        }
        public function get health(): int {
            return this._health;
        }
        public function hit(attacker: ICanAttack): void {
            this._health -= attacker.damage;
            if (this._health <= 0) {
                this._health = 0;
                this.dispatchEvent(new Event("dead"));
                this.game.removeMonster(this);
                this.game.mission -= 1;
                this.game.score += 20;
            }
        }
        public function getHitArea(): DisplayObject {
            return this;
        }

        // ICanAttack
        public function set targets(value: Vector.<ICanDie>): void {
            this._targets = value;
        }
        public function get damage(): int {
            return 10;
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

        private function move(): void {
            this._t += 0.2;
            this.x -= 3 + Math.sin(this._t) * 3;
        }

        private function shot(): void {
            if (_targets && _targets.length > 0) {
                for each (var target: ICanDie in _targets) {
                    if (target.getHitArea().hitTestObject(this)) {
                        target.hit(this);
                        break;
                    }
                }
            }
        }

        private function ENTER_FRAME(e: Event): void {
            move();
            if (this.x + this.width < 0)
                this.game.removeMonster(this);
        }
    }
}
