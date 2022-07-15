
class KGamesNames{
  static String name(String gameNameId, String localeName){
    switch(gameNameId){
      case '1_to_10':
        if(localeName == "en"){
          return "Friends?";
        }else{
          return "Freunde?";
        }
        break;
      default:
        return "";
    }
  }
}