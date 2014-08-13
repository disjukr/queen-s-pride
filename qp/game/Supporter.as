package qp.game {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.geom.Point;

    import qp.util.MathUtil;
    public class Supporter extends MovieClip implements Pausable {
        private static var MOVE_EASING: Number = 0.2;
        private static var SHOT_DELAY: int = 8;
        
        public var game: Game;
        public var anchor: Point;
        public var focusAnchor: Point;
        public var focus: Boolean;

        private var _shotPool: SupporterShotPool;
        private var _shotCool: int;

        public function Supporter() {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this._shotPool = new SupporterShotPool;
            this._shotCool = 0;
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

        private function shot(): void {
            var shot: SupporterShot = _shotPool.alloc();
            shot.x = this.x + 70;
            shot.y = this.y;
            if (game.dynamicArea)
                game.dynamicArea.addChild(shot);
            shot.resume();
        }

        private function ENTER_FRAME(e: Event): void {
            move();
            if (++this._shotCool > SHOT_DELAY) {
                this._shotCool = 0;
                shot();
            }
        }
    }
}
