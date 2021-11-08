package game.char;

class RemoteBomb extends Bomb {
  /**
   * Special function that will detonate the bomb
   * once this is called.
   */
  public function detonate() {
    presentBombTimer = 0.5;
  }
}