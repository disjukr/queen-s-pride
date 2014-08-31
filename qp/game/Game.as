package qp.game {

    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.geom.Point;

    import qp.game.background.Background;

    public class Game extends MovieClip implements Pausable {
        public var player: Player;
        public var players: Vector.<ICanDie>;
        public var skillBar: MovieClip;
        public var supporters: Vector.<Supporter>;
        public var background: Background;

        private var _mission: int;
        private var _score: int;
        public var coinHook: Function;
        public var missionHook: Function;
        public var scoreHook: Function;
        public var gameEndHook: Function;

        // 동적으로 화면에 무언가를 배치하기 위한 영역
        // 경고 표시를 위쪽에 그리기 위해서 동적으로 생성되는 객체,
        // 총알, 서포터 적 등은 이 곳에 생성한다.
        public var dynamicArea: MovieClip;

        public function Game() {
            supporters = new Vector.<Supporter>;
            players = new Vector.<ICanDie>;
            super();
        }

        public function set mission(value: int): void {
            _mission = Math.max(0, value);
            if (missionHook != null) missionHook();
        }

        public function get mission(): int {
            return _mission;
        }

        public function set score(value: int): void {
            _score = Math.max(0, value);
            if (scoreHook != null) scoreHook();
        }

        public function get score(): int {
            return _score;
        }

        public function addSupporter(supporterClass: Class, anchor: Point): void {
            var supporter: Supporter = new supporterClass;
            supporter.game = this;
            supporter.anchor = anchor;
            if (this.player) {
                supporter.x = this.player.x - anchor.x;
                supporter.y = this.player.y - anchor.y;
            }
            dynamicArea.addChild(supporter);
            supporters.push(supporter);
            // calc focus anchor
            var lift: Number = (this.supporters.length - 1) * 30 * 0.5;
            this.supporters.forEach(function (supporter: Supporter, index, vector): void {
                supporter.focusAnchor = new Point(-40, 30 * index - lift);
            });
        }
        public function emitCoin(quantity: int, emitPoint: DisplayObject): void {
            var coin: Coin = new Coin(quantity,
                                      Math.random() * 10 - 8,
                                      -(Math.random() * 5 + 3));
            coin.game = this;
            coin.x = emitPoint.x;
            coin.y = emitPoint.y;
            dynamicArea.addChild(coin);
            coin.resume();
        }
        public function spawnMonster(monsterClass: Class, spawnPoint: DisplayObject): void {
            var monster: MovieClip = new monsterClass;
            monster.game = this;
            monster.targets = players;
            monster.x = spawnPoint.x;
            monster.y = spawnPoint.y;
            dynamicArea.addChild(monster);
            player.enemies.push(ICanDie(monster));
            monster.resume();
        }
        public function removeMonster(monster: MovieClip): void {
            monster.pause();
            dynamicArea.removeChild(monster);
            var idx: int = player.enemies.indexOf(ICanDie(monster));
            if (idx > -1)
                player.enemies.splice(idx, 1);
        }
        public function focus(value: Boolean): void {
            this.player.focus = value;
            this.supporters.forEach(function (supporter: Supporter, index, vector): void {
                supporter.focus = value;
            });
        }
        public function pause(): void {
            this.stop();
            this.player.pause();
            this.skillBar.pause();
            for (var i: int = 0; i < this.dynamicArea.numChildren; ++i) {
                var pausable: Pausable;
                try {
                    pausable = Pausable(this.dynamicArea.getChildAt(i));
                } catch (e) {
                    pausable = null;
                }
                if (pausable) pausable.pause();
            }
            this.background.pause();
        }
        public function resume(): void {
            if (this.currentFrame < this.totalFrames &&
                this.player.state == Player.LIVE)
                this.play();
            this.player.resume();
            if (this.skillBar && this.skillBar.resume)
                this.skillBar.resume();
            for (var i: int = 0; i < this.dynamicArea.numChildren; ++i) {
                var pausable: Pausable;
                try {
                    pausable = Pausable(this.dynamicArea.getChildAt(i));
                } catch (e) {
                    pausable = null;
                }
                if (pausable) pausable.resume();
            }
            this.background.resume();
        }
    }
}
