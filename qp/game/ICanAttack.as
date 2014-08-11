package qp.game {
    public interface ICanAttack { // only bullets can attack
        function set targets(value: Vector.<ICanDie>): void;
        function get damage(): int;
    }
}
