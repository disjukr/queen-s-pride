package qp.game {
    public interface ICanDie {
        function get maxHealth(): int;
        function get health(): int;
        function hit(attacker: ICanAttack): void;
    }
}
