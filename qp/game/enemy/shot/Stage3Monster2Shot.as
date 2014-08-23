package qp.game.enemy.shot {
    import flash.display.MovieClip;
    import flash.events.Event;

    import qp.game.*;

    public class Stage3Monster2Shot extends MovieClip implements Pausable, ICanAttack {
        
        private var _targets: Vector.<ICanDie>;

        public function Stage3Monster2Shot() {
            this.init();
        }
        public function set targets(value: Vector.<ICanDie>): void {
            this._targets = value;
        }
        public function get damage(): int {
            return 10;
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
            this.removeEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }
        public function resume(): void {
            this.play();
            this.addEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }

        private function ENTER_FRAME(e: Event): void {
            x -= 7;
            if (_targets && _targets.length > 0) {
                for each (var target: ICanDie in _targets) {
                    if (target.getHitArea().hitTestPoint(x, y)) {
                        target.hit(this);
                        this.destroy();
                        break;
                    }
                }
            }
            if (stage) {
                if ((this.x + this.width) < 0) {
                    this.destroy();
                    return;
                }
            }
        } // end ENTER_FRAME
    }
}
