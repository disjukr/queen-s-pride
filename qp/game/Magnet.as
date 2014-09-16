package qp.game {

    public class Magnet extends Item {

        override protected function effect(): void {
            for each (var coin: Coin in Coin.list) {
                coin.magnet = true;
            }
        }

    }
}
