package qp.game {

    public class Potion extends Item {

        override protected function effect(): void {
            game.player.heal(50);
        }

    }
}
