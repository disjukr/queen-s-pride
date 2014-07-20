package qp.game.background {

    import flash.display.MovieClip;
    public class ParallelSet extends MovieClip implements Scrollable {
        private var _t: Number;
        // ParallelSet의 모든 자식들은 Scrollable이라 가정
        public function ParallelSet() {
            this.t = 0;
        }
        public function get t(): Number {
            return this._t;
        }
        public function set t(value: Number): void {
            this._t = value;
            for (var i: int = 0; i < this.numChildren; ++i)
                Scrollable(this.getChildAt(i)).t = value;
        }
    }
}
