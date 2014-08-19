package qp.game.enemy {

    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;

    import qp.game.*;
    import qp.util.MathUtil;

    public class Stage3Monster1 extends Monster implements ICanAttack {

        private var _t: Number;
        private var _targets: Vector.<ICanDie>;

        public function Stage3Monster1() {
            this._health = this._maxHealth = 200;
            this._t = 0;
        }

        override public function hit(attacker: ICanAttack): void {
            if (this._state != LIVE)
                return;
            super.hit(attacker);
            if (this._health == 0) {
                this.game.mission -= 1;
                this.game.score += 20;
            }
        }

        // ICanAttack
        public function set targets(value: Vector.<ICanDie>): void {
            this._targets = value;
        }
        public function get damage(): int {
            return 10;
        }

        override protected function move(): void {
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

    }
}
