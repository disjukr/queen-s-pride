package qp.game {
    
    import flash.display.MovieClip;
    import flash.events.Event;

    import qp.util.MathUtil;

    public class Player extends MovieClip implements IGameObject, ICanDie {

        private static var DEFAULT_MAX_HEALTH: int = 100;
        private static var DEFAULT_HEALTH: int = 100;
        private static var MOVE_EASING: Number = 0.4; // 0 ~ 1 사이의 값.
                                                      // 캐릭터의 좌표는 매 프레임 이 값을 기준으로 선형보간되며
                                                      // 1에 가까울 수록 목표좌표에 빠르게 다가간다.

        private var _health: int;
        private var _moveTargetX: Number;
        private var _moveTargetY: Number;

        public function Player() {
            this.setTo(0, 0);
            this._health = DEFAULT_HEALTH;
            addListeners();
        }

        public function setTo(positionX: Number, positionY: Number): void { // 좌표를 설정. 목표 좌표도 같이 설정된다.
            this.x = positionX;
            this.y = positionY;
            this.moveTo(positionX, positionY);
        }
        public function moveTo(targetX: Number, targetY: Number): void { // 목표 좌표를 설정. 플레이어는 해당 좌표로 점진적으로 움직이게 된다.
            this._moveTargetX = targetX;
            this._moveTargetY = targetY;
        }

        // ICanDie
        public function get maxHealth(): int {
            return DEFAULT_MAX_HEALTH;
        }
        public function get health(): int {
            return this._health;
        }
        public function hit(attacker: ICanAttack): void {
            // do nothing currently
        }

        // IGameObject
        public function pause(): void {
            removeListeners();
        }
        public function resume(): void {
            addListeners();
        }
        public function destroy(): void {
            removeListeners();
        }

        private function addListeners(): void {
            this.addEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }
        private function removeListeners(): void {
            this.removeEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }

        private function ENTER_FRAME(e: Event): void {
            this.x = MathUtil.linear(this.x, this._moveTargetX, MOVE_EASING);
            this.y = MathUtil.linear(this.y, this._moveTargetY, MOVE_EASING);
        }
    }
}
