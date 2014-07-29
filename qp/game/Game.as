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
            this.stop();
            this.player.pause();
            this.background.pause();
        }
        public function resume(): void {
            if (this.currentFrame < this.totalFrames &&
                this.player.state == Player.LIVE)
                this.play();
            this.player.resume();
            this.background.resume();
        }
    }
}