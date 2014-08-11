package qp.game {
    public class PlayerShotPool {
        private var _shots: Vector.<PlayerShot>;
        public function PlayerShotPool() {
            _shots = new Vector.<PlayerShot>;
        }
        public function alloc(): PlayerShot {
            var shot: PlayerShot;
            if (_shots.length < 1)
                shot = new PlayerShot(this);
            else
                shot = _shots.pop();
            shot.init();
            return shot;
        }
        public function free(shot: PlayerShot): void {
            _shots.push(shot);
        }
    }
}
