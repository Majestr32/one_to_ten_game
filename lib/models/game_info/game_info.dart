class GameInfo{
  final String name;
  final String idName;
  final String assetPath;
  final String? onClickRoutePath;
  final int minRounds;
  final int maxRounds;
  final int minPlayers;
  final int maxPlayers;
  final int? minMinutesPlay;
  final int? maxMinutesPlay;

  const GameInfo({
    required this.name,
    required this.minRounds,
    required this.maxRounds,
    required this.idName,
    required this.assetPath,
    required this.minPlayers,
    required this.maxPlayers,
    this.onClickRoutePath,
    this.minMinutesPlay,
    this.maxMinutesPlay,
  });
  String get timeInfo{
    if(minMinutesPlay == null && maxMinutesPlay == null){
      return "- min";
    }else if(minMinutesPlay != null && maxMinutesPlay != null){
      return minMinutesPlay.toString() + "-" + maxMinutesPlay.toString() + " min";
    }else if(minMinutesPlay != null){
      return "Min. " + minMinutesPlay.toString() + " min";
    }else{
      return "Max. " + maxMinutesPlay.toString() + " min";
    }
  }
}