package qp.game {
    public interface ICanAttack { // only bullets can attack
        function set target(value: IGameObject): void;
        function get damage(): int;
    }
}
