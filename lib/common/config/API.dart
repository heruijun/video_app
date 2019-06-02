import 'package:video_app/common/utils/http_util.dart';
import 'package:video_app/model/movie_detail_bean.dart';
import 'package:video_app/model/subject_entity.dart';

typedef RequestCallBack<T> = void Function(T value);

class API {
  static const BASE_URL = "https://api.douban.com";
  static const String MOVIES =
      '/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b';

  // 电影列表
  void getMovies(RequestCallBack requestCallBack) async {
    Map result = await HttpUtil().get(MOVIES);
    var resultList = result['subjects'];
    List<Subject> movies =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack({'movies': movies});
  }

  // 电影详情
  void getMovieDetail(subjectId, RequestCallBack requestCallBack) async {
    final result = await HttpUtil().get(
        '/v2/movie/subject/$subjectId?apikey=0b2bdeda43b5688921839c8ecb20399b');
    MovieDetailBean bean = MovieDetailBean.fromJson(result);
    requestCallBack(bean);
  }
}
