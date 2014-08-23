package qp.game.enemy {

    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;

    import qp.game.*;
    import qp.game.enemy.shot.*;

    public class Stage3Boss extends Monster implements ICanAttack {

        public static var COME: String = 'come';
        public static var LIVE: String = 'live';
        public static var SKILL: String = 'skill';
        public static var WEAK: String = 'weak';
        public static var DEAD: String = 'dead';

        public var state: String;

        public var animation: MovieClip;
        private var _anim_t: Number;

        private var _targets: Vector.<ICanDie>;
        private var _shot_t: Number;
        private var _shot_d: int;

        public function Stage3Boss() {
            this.state = COME;
            this._health = this._maxHealth = 30000;
            this._anim_t = 0;
            this._shot_t = 0;
            this._shot_d = 0;
        }

        override public function hit(attacker: ICanAttack): void {
            if (this.state == DEAD)
                return;
            super.hit(attacker);
            this.game.score += 1;
            if (this._health == 0) {
                this.game.score += 5000;
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
            this.x -= 4;
        }

        private function shot(): void {
            var shot: Stage3BossShot = new Stage3BossShot();
            shot.x = stage.stageWidth + shot.width;
            shot.y = this._shot_t * stage.stageHeight;
            shot.targets = game.players;
            if (game.dynamicArea)
                game.dynamicArea.addChild(shot);
            shot.resume();
        }

        override protected function ENTER_FRAME(e: Event): void {
            if (this.state != DEAD && this._health <= 0)
                this.state = DEAD;
            switch (this.state) {
            case COME:
                move();
                if (this.currentLabel != "default")
                    this.gotoAndStop("default");
                if (this.x + (this.width * 0.5) < stage.stageWidth)
                    this.state = LIVE;
                break;
            case LIVE:
                if (this.currentLabel != "default")
                    this.gotoAndStop("default");
                if (this._health < 17000)
                    this.state = WEAK;
                break;
            case SKILL:
                if (this.currentLabel != "skill")
                    this.gotoAndStop("skill");
                break;
            case WEAK:
                if (this.currentLabel != "weak")
                    this.gotoAndStop("weak");
                break;
            case DEAD:
                if (this.currentLabel != "death")
                    this.gotoAndStop("death");
                this.x += 0.5;
                this.alpha -= 0.005;
                if (this.alpha < 0) {
                    this.game.removeMonster(this);
                    // TODO: game clear
                }
                break;
            }
            if (this.animation != null) {
                this._anim_t += 0.05;
                this.animation.y = Math.sin(this._anim_t) * 20;
            }
            this._shot_t += 0.025;
            this._shot_d++;
            if (this._shot_d > 10) {
                this._shot_d = 0;
                // shot();
            }
        }

    }
}
