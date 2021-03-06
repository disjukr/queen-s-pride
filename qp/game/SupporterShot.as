package qp.game {
    import flash.display.MovieClip;
    import flash.events.Event;

    public class SupporterShot extends MovieClip implements Pausable, ICanAttack {
        private var dx: Number;
        private var _targets: Vector.<ICanDie>;
        private var _pool: SupporterShotPool;

        public function SupporterShot(pool) {
            this._pool = pool;
            this.init();
        }
        public function set targets(value: Vector.<ICanDie>): void {
            this._targets = value;
        }
        public function get damage(): int {
            return 25;
        }

        public function init(): void {
            this.dx = 0;
            this._targets = null;
        }

        public function destroy(): void {
            this.pause();
            if (this.parent)
                this.parent.removeChild(this);
            this._pool.free(this);
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
            x += dx += 0.4;
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
                if ((this.x - this.width) > stage.stageWidth) {
                    this.destroy();
                    return;
                }
            }
        } // end ENTER_FRAME
    }
}
