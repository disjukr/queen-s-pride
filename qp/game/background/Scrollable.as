package qp.game.background {
    public interface Scrollable {
        function get t(): Number; // 0 ~ 1
        function set t(value: Number): void;
    }
}
