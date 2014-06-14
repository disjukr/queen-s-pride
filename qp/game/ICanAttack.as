package qp.game {
    public interface ICanAttack { // only bullets can attack
        function set target(value: Vector.<IGameObject>): void;
        function get damage(): int;
    }
}
