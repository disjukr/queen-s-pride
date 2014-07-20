package qp.game.background {
    import flash.display.MovieClip;
    import qp.game.Pausable;
    public class Background extends MovieClip implements Pausable {
        public function Background() {
            super();
        }
        public function pause(): void {
            return;
        }
        public function resume(): void {
            return;
        }
    }
}
