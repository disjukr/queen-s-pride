package qp.game.background {

    import flash.display.MovieClip;
    public class Repeat extends MovieClip implements Scrollable {
        private var _x: Number;
        private var _t: Number;
        private var _m: Number;
        public function Repeat() {
            super();
            this.t = 0;
            this.m = 1;
        }
        override public function get width(): Number {
            return super.width >>> 1;
        }
        override public function set width(value: Number): void {
            super.width = value + value;
        }
        override public function get x(): Number {
            return this._x;
        }
        override public function set x(value: Number): void {
            this._x = value;
            super.x = value % this.width;
        }
        public function get t(): Number {
            return this._t;
        }
        public function set t(value: Number): void {
            this._t = value;
            this.x = -this.t * this.m;
        }
        public function get m(): Number {
            return this._m;
        }
        public function set m(value: Number): void {
            this._m = value;
        }
    }
}
