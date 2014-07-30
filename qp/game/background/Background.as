package qp.game.background {
    import flash.display.MovieClip;
    import qp.game.Pausable;
    public class Background extends MovieClip implements Pausable {
        public function Background() {
            super();
            this.mouseEnabled = false;
            this.mouseChildren = false;
        }
        public function pause(): void {
            return;
        }
        public function resume(): void {
            return;
        }
    }
}
