package qp.game.enemy.shot {
    import flash.display.MovieClip;
    import flash.events.Event;

    import qp.game.*;

    public class Stage3BossSkill extends MovieClip implements Pausable, ICanAttack {
        
        private var _targets: Vector.<ICanDie>;

        public function Stage3BossSkill() {
            this.init();
        }
        public function set targets(value: Vector.<ICanDie>): void {
            this._targets = value;
        }
        public function get damage(): int {
            return 60;
        }

        public function init(): void {
            this._targets = null;
        }

        public function destroy(): void {
            this.pause();
            if (this.parent)
                this.parent.removeChild(this);
        }

        public function pause(): void {
            this.stop();
        }
        public function resume(): void {
            this.play();
        }
    }
}
