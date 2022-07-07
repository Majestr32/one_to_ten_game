import '../../models/game_info/game_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class IGamesRepository{
  List<GameInfo> getGamesList();
  void init(AppLocalizations localizations);
}