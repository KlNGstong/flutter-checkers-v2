class GameRuleExeption implements Exception {
  final String cause;

  GameRuleExeption([this.cause = '']);
}
