import 'package:todo_app/entity/rank_rate.dart';
import 'package:todo_app/dao/rank_rate_dao.dart';

class RankRateRepository {
  final rankRateDao = RankRateDao();

  Future getAllRankRate() => rankRateDao.getAll();

  Future getRankRateByID(int id) => rankRateDao.getRecordId(id);

  Future insertRankRate(RankRate rankRate) => rankRateDao.create(rankRate);

  Future updateRankRate(RankRate rankRate) => rankRateDao.update(rankRate);

  Future deleteRankRateById(int id) => rankRateDao.delete(id);

  Future deleteRankRateByRecordId(int id) => rankRateDao.deleteByRecordId(id);

  //not use this
  Future deleteAllRankRate() => rankRateDao.deleteAll();
}
