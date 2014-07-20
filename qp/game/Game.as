package qp.game {

    import flash.display.MovieClip;

    import qp.game.background.Background;

    public class Game extends MovieClip implements Pausable {
        public var background: Background;
        public function Game() {
            super();
        }
        public function pause(): void {
            this.background.pause();
        }
        public function resume(): void {
            this.background.resume();
        }
    }
}
