package qp.game {

    import flash.display.MovieClip;
    import flash.geom.Point;

    import qp.game.background.Background;

    public class Game extends MovieClip implements Pausable {
        public var player: Player;
        public var supporters: Vector.<Supporter>;
        public var background: Background;
        public var dynamicArea: MovieClip;
        public function Game() {
            supporters = new Vector.<Supporter>;
            super();
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
        public function focus(value: Boolean): void {
            this.player.focus = value;
            this.supporters.forEach(function (supporter: Supporter, index, vector): void {
                supporter.focus = value;
            });
        }
        public function pause(): void {
            this.stop();
            this.player.pause();
            this.supporters.forEach(function (supporter: Supporter, index, vector): void {
                supporter.pause();
            });
            this.background.pause();
        }
        public function resume(): void {
            if (this.currentFrame < this.totalFrames &&
                this.player.state == Player.LIVE)
                this.play();
            this.player.resume();
            this.supporters.forEach(function (supporter: Supporter, index, vector): void {
                supporter.resume();
            });
            this.background.resume();
        }
    }
}
