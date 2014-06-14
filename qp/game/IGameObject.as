package qp.game {
    public interface IGameObject {
        function pause(): void;
        function resume(): void;
        function destroy(): void;
    }
}
