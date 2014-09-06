package qp.game {
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;

    public class Coin extends MovieClip implements Pausable {

        public var game: Game;

        private var _dx: Number;
        private var _dy: Number;

        public var quantity: int;

        public function Coin(quantity: int, dx: Number, dy: Number) {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this._dx = dx;
            this._dy = dy;
            this.quantity = quantity;
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

        private function ENTER_FRAME(e: Event): void {
            this._dy += 0.2;
            this.x += this._dx;
            this.y += this._dy;
            if (this.game.player.getHitArea().hitTestPoint(this.x, this.y)) {
                if (this.game.coinHook != null)
                    this.game.coinHook(this.quantity);
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
