package qp.game {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.geom.Point;

    import qp.util.MathUtil;
    public class Supporter extends MovieClip implements Pausable {
        private static var MOVE_EASING: Number = 0.2;
        
        public var game: Game;
        public var anchor: Point;
        public var focusAnchor: Point;
        public var focus: Boolean;
        public function Supporter() {
            this.mouseEnabled = false;
            this.mouseChildren = false;
        }
        // Pausable
        public function pause(): void {
            this.stop();
            removeListeners();
        }
        public function resume(): void {
            this.play();
            addListeners();
        }
        private function addListeners(): void {
            this.addEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }
        private function removeListeners(): void {
            this.removeEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }

        private function move(): void {
            var player: Player = this.game.player;
            if (!player)
                return;
            var anchor: Point = this.focus ? this.focusAnchor : this.anchor;
            this.x = MathUtil.linear(this.x, player.x - anchor.x, MOVE_EASING);
            this.y = MathUtil.linear(this.y, player.y - anchor.y, MOVE_EASING);
        }

        private function ENTER_FRAME(e: Event): void {
            move();
        }
    }
}
