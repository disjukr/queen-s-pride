package qp.game {

    import flash.display.MovieClip;

    import qp.game.background.Background;

    public class Game extends MovieClip implements Pausable {
        public var player: Player;
        public var background: Background;
        public function Game() {
            super();
        }
        public function pause(): void {
            this.player.pause();
            this.background.pause();
        }
        public function resume(): void {
            this.player.resume();
            this.background.resume();
        }
    }
}
