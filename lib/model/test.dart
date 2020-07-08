void main() {
  Map<String, int> scoreMap = {'a':0, 'b':0, 'c':0, 'd':0};
  List<Name> nameList = [Name(name:'a', nameId:1),Name(name:'b', nameId:2),Name(name:'c', nameId:3),Name(name:'d', nameId:4)];
  List<List<RecordContents>> recordContentsPerCount = [[RecordContents(nameId:1, score:1),RecordContents(nameId:2, score:1),RecordContents(nameId:3, score:3),RecordContents(nameId:4, score:3),]];
  List<RankRate> recordRankRateList = [RankRate(rank:1, rate:100),RankRate(rank:2, rate:50),RankRate(rank:3, rate:-50),RankRate(rank:4, rate:-100)];
  
  duplicateCalcScore(nameList, recordContentsPerCount, scoreMap, recordRankRateList);
  
}

  void duplicateCalcScore(List<Name> recordNameList, List<List<RecordContents>> recordContentsPerCount, Map<String, int> scoreMap, List<RankRate> recordRankRateList) {
    for (final perCount in recordContentsPerCount) {
      List<List<RecordContents>> dupLists = [];
      for (final recordContents1 in perCount) {
        int dupCount = 0;
        final List<RecordContents> dupList = [];
        for (final recordContents2 in perCount) {
          if (recordContents1.score == recordContents2.score) {
            dupCount++;
            if (dupCount == 2) {
              dupList.add(recordContents1);
              dupList.add(recordContents2);
              dupLists.add(dupList);
            } else if (dupCount > 2) {
              dupList.add(recordContents2);
              dupLists.add(dupList);
            }
          }
        }
      }
      var rankTmp = 0;
      List<List<RecordContents>> dupListsB = [];
      for(final dupList in dupLists){
        if(rankTmp != dupList[0].score){
          dupListsB.add(dupList);
          rankTmp = dupList[0].score;
        }
      }
      final List<RecordContents> flatDupList = dupListsB.expand((pair) => pair).toList();
      final List<RecordContents> noDupList =
          perCount.where((element) => !flatDupList.contains(element)).toList();
      for (final name in recordNameList) {
        for (final contents in noDupList) {
          if (name.nameId == contents.nameId) {
            for (final rankRate in recordRankRateList) {
              if (contents.score == rankRate.rank){
                scoreMap[name.name] = scoreMap[name.name] + rankRate.rate;
              }
            }
          }
        }
      }
      
      if(dupListsB.isNotEmpty){
        for(final dupList in dupListsB){
          int dupRate = 0;
          for(int i =0; i < dupList.length; i++){
            for(final contents in dupList){
              print(contents.nameId);
              for(final rankRate in recordRankRateList){
                if(contents.score + i == rankRate.rank){
                  dupRate += rankRate.rate;
                }
              }
            }
          }
          dupRate = (dupRate / dupList.length).round();
          for(final name in recordNameList){
            for(final contents in dupList){
              if(name.nameId == contents.nameId){
                scoreMap[name.name] = scoreMap[name.name] + dupRate;
              }
            }
          }
        }
        print(scoreMap);
      }
    }
  }

class Name {
  String name;
  int nameId;

  Name({
    this.name,
    this.nameId
  });
} 
 
class RecordContents{
  int nameId;
  int score;

  RecordContents({this.nameId, this.score});
}


class RankRate {
  int rank;
  int rate;

  RankRate({this.rank, this.rate = 1});

}