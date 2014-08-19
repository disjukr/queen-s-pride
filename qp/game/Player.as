package qp.game {
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;

    import qp.util.MathUtil;

    public class Player extends MovieClip implements Pausable, ICanDie {

        public static var LIVE: String = 'live';
        public static var HURT: String = 'hurt';
        public static var DEAD: String = 'dead';

        private static var DEFAULT_MAX_HEALTH: int = 100;
        private static var DEFAULT_HEALTH: int = 100;
        private static var HURT_TIME: int = 40;
        private static var HURT_BLINK_TIME: int = 10;
        private static var HURT_BLINK_ALPHA: Number = 0.2;
        private static var MOVE_EASING: Number = 0.4; // 0 ~ 1 사이의 값.
                                                      // 캐릭터의 좌표는 매 프레임 이 값을 기준으로 선형보간되며
                                                      // 1에 가까울 수록 목표좌표에 빠르게 다가간다.
        private static var FOCUS_EASING: Number = 0.05;
        private static var SHOT_DELAY: int = 5;

        public var game: Game;
        public var focus: Boolean;
        public var enemies: Vector.<ICanDie>;

        private var _health: int;
        private var _state: String;
        private var _hurtTime: int;
        private var _hurtBlinkTime: int;
        private var _moveTargetX: Number;
        private var _moveTargetY: Number;

        private var _dy: Number; // 죽는 상황에만 사용됨

        private var _shotPool: PlayerShotPool;
        private var _shotCool: int;

        public function Player() {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this._health = DEFAULT_HEALTH;
            this._state = LIVE;
            this._shotPool = new PlayerShotPool;
            this._shotCool = 0;
            this.enemies = new Vector.<ICanDie>;
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

        public function get state(): String {
            return this._state;
        }

        // ICanDie
        public function get maxHealth(): int {
            return DEFAULT_MAX_HEALTH;
        }
        public function get health(): int {
            return this._health;
        }
        public function hit(attacker: ICanAttack): void {
            switch (this._state) {
            case LIVE:
                this._health -= attacker.damage;
                if (this._health <= 0) {
                    this._health = 0;
                    this._state = DEAD;
                    this._dy = -10;
                    this.gotoAndStop("death");
                    this.dispatchEvent(new Event("dead"));
                }
                break;
            }
        }
        public function getHitArea(): DisplayObject {
            return this;
        }

        // Pausable
        public function pause(): void {
            if (this._animation is MovieClip)
                _animation.stop();
            if (this._attack_effect is MovieClip)
                _attack_effect.stop();
            removeListeners();
        }
        public function resume(): void {
            if (this._animation is MovieClip)
                _animation.play();
            if (this._attack_effect is MovieClip)
                _attack_effect.play();
            addListeners();
        }

        private function addListeners(): void {
            this.addEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }
        private function removeListeners(): void {
            this.removeEventListener(Event.ENTER_FRAME, ENTER_FRAME);
        }

        private function move(): void {
            var easing: Number = this.focus ? FOCUS_EASING : MOVE_EASING;
            this.x = MathUtil.linear(this.x, this._moveTargetX, easing);
            this.y = MathUtil.linear(this.y, this._moveTargetY, easing);
        }

        private function shot(): void {
            var shot: PlayerShot = _shotPool.alloc();
            shot.x = this.x + 100;
            shot.y = this.y;
            shot.targets = this.enemies;
            if (game.dynamicArea)
                game.dynamicArea.addChild(shot);
            shot.resume();
        }

        private function ENTER_FRAME(e: Event): void {
            switch (this._state) {
            case LIVE:
                move();
                if (++this._shotCool > SHOT_DELAY) {
                    this._shotCool = 0;
                    shot();
                }
                break;
            case HURT:
                this.alpha = (this._hurtBlinkTime > (HURT_BLINK_TIME >> 1)) ?
                             HURT_BLINK_ALPHA : 1;
                this._hurtBlinkTime = (this._hurtBlinkTime + 1) % HURT_BLINK_TIME;
                if (--this._hurtTime <= 0) {
                    this.alpha = 1;
                    this._state = LIVE;
                }
                move();
                break;
            case DEAD:
                this._dy += 1;
                this.y += this._dy;
                break;
            }
        }
    }
}
