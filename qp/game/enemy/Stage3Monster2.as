package qp.game.enemy {

    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;

    import qp.game.*;
    import qp.game.enemy.shot.*;

    public class Stage3Monster2 extends Monster implements ICanAttack {

        private var _s: int;
        private var _a: int;
        private var _c: int;
        private var _targets: Vector.<ICanDie>;

        public function Stage3Monster2() {
            this._health = this._maxHealth = 400;
            this._s = 0;
            this._a = 0;
            this._c = 0;
        }

        override public function hit(attacker: ICanAttack): void {
            if (this._state != LIVE)
                return;
            super.hit(attacker);
            this.game.score += 2;
            if (this._health == 0) {
                this.game.score += 400;
                this.game.emitCoin(15 + Math.random() * 5, this);
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
            this.x -= 2;
        }

        private function shot(): void {
            var shot: Stage3Monster2Shot = new Stage3Monster2Shot();
            shot.x = this.x - 100;
            shot.y = this.y;
            shot.targets = game.players;
            if (game.dynamicArea)
                game.dynamicArea.addChild(shot);
            shot.resume();
        }

        override protected function ENTER_FRAME(e: Event): void {
            super.ENTER_FRAME(e);
            this._s++;
            this._a++;
            if (this._s > 40 && this._c < 3) {
                this._s = 0;
                this.shot();
                this._c++;
            }
            if (this._a > 350) {
                this._a = 0;
                this._c = 0;
            }
        }

    }
}
