package qp.game.enemy {

    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;

    import qp.game.*;
    import qp.util.MathUtil;

    public class Stage3Monster3 extends Monster implements ICanAttack {

        private var _t: Number;
        private var _targets: Vector.<ICanDie>;

        public function Stage3Monster3() {
            this._health = this._maxHealth = 500;
            this._t = 0;
        }

        override public function hit(attacker: ICanAttack): void {
            if (this._state != LIVE)
                return;
            this.game.score += 2;
            super.hit(attacker);
            if (this._health == 0) {
                this.game.mission -= 1;
                this.game.score += 200;
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
            this._t += 0.05;
            this.x -= 2;
            this.y += Math.sin(this._t) * 5;
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
