package qp.game {
    import flash.display.DisplayObject;
    public interface ICanDie {
        function get maxHealth(): int;
        function get health(): int;
        function hit(attacker: ICanAttack): void;
        function getHitArea(): DisplayObject;
    }
}
