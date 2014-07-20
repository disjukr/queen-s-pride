package qp.game.background {
    
    import flash.display.MovieClip;
    public class Once extends MovieClip implements Scrollable {
        private var _x: Number;
        private var _t: Number;
        private var _b: Number; // bound. 눈에 보이는 배경화면 너비
        public function Once() {
            super();
            this.t = 0;
            this.b = 0;
        }
        public function get t(): Number {
            return this._t;
        }
        public function set t(value: Number): void {
            this._t = value;
            this.x = -this.t * (this.width - this.b);
        }
        public function get b(): Number {
            return this._b;
        }
        public function set b(value: Number): void {
            this._b = value;
        }
    }
}
