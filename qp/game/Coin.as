package qp.game {
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;

    public class Coin extends MovieClip implements Pausable {

        public var game: Game;

        private var _dx: Number;
        private var _dy: Number;

        public var quantity: int;
        public var magnet: Boolean;

        public static var list: Vector.<Coin>;

        public function Coin(quantity: int, dx: Number, dy: Number) {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this._dx = dx;
            this._dy = dy;
            this.quantity = quantity;
            this.magnet = false;
            Coin.list.push(this);
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
            this.pause();
            if (this.parent != null)
                this.parent.removeChild(this);
            Coin.list.splice(Coin.list.indexOf(this), 1);
        }

        private function ENTER_FRAME(e: Event): void {
            var px: Number = game.player.x;
            var py: Number = game.player.y;
            var ldx: Number = px - x;
            var ldy: Number = py - y;
            var dir: Number = Math.atan2(ldy, ldx);
            if (magnet) {
                x += Math.cos(dir) * 30;
                y += Math.sin(dir) * 30;
            } else {
                this._dy += 0.2;
                this.x += this._dx;
                this.y += this._dy;
            }
            if (this.game.player.getHitArea().hitTestPoint(this.x, this.y)) {
                SoundManager.event("coin");
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
