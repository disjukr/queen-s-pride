package qp.game {
    import flash.display.MovieClip;
    import flash.events.Event;

    public class PlayerSkill extends MovieClip implements Pausable, ICanAttack {
        public var _targets: Vector.<ICanDie>;

        public function PlayerSkill() {
            this.init();
        }
        public function set targets(value: Vector.<ICanDie>): void {
            this._targets = value;
        }
        public function get damage(): int {
            return 500;
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
