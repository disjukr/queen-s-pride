package qp.game {
    public class SupporterShotPool {
        private var _shots: Vector.<SupporterShot>;
        public function SupporterShotPool() {
            _shots = new Vector.<SupporterShot>;
        }
        public function alloc(): SupporterShot {
            var shot: SupporterShot;
            if (_shots.length < 1)
                shot = new SupporterShot(this);
            else
                shot = _shots.pop();
            shot.init();
            return shot;
        }
        public function free(shot: SupporterShot): void {
            _shots.push(shot);
        }
    }
}
