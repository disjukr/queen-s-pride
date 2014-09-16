package qp.game {
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;

    public class Item extends MovieClip implements Pausable {

        public var game: Game;
        private var _t: Number;
        private var _dx: Number;

        public function Item() {
            _dx = 0;
            _t = Math.random();
        }

        // Pausable
        public function pause(): void {
            removeListeners();
        }
        public function resume(): void {
            addListeners();
        }

        private function addListeners(): void {
            this.addEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }
        private function removeListeners(): void {
            this.removeEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }

        private function destroy(): void {
            if (this.parent != null)
                this.parent.removeChild(this);
            this.pause();
        }

        protected function effect(): void {
            // no effect
        }

        private function ENTER_FRAME(e: Event): void {
            _dx -= 0.2;
            x += _dx;
            y += Math.sin(_t) * 3;
            this._t += 0.1;
            if (this.game.player.getHitArea().hitTestPoint(this.x, this.y)) {
                SoundManager.event("item");
                var ca: ConsumeAnimation = new ConsumeAnimation;
                ca.x = this.x;
                ca.y = this.y;
                game.dynamicArea.addChild(ca);
                effect();
                destroy();
            }
            if (stage != null) {
                if (this.y - this.height > stage.stageHeight) {
                    destroy();
                }
            }
        }
    }
}
