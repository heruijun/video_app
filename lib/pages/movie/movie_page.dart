import 'package:flutter/material.dart';
import 'package:video_app/common/config/API.dart';
import 'package:video_app/components/image/movie_image.dart';
import 'package:video_app/components/router.dart';
import 'package:video_app/model/subject_entity.dart';

import 'today_play_movie_widget.dart';

final API _api = API();

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with AutomaticKeepAliveClientMixin {
  List<Subject> movies = List();
  List<String> todayUrls = [];
  var itemW;

  @override
  void initState() {
    super.initState();
    _api.getMovies((map) {
      movies = map['movies'];
      todayUrls.add(movies[0].images.medium);
      todayUrls.add(movies[1].images.medium);
      todayUrls.add(movies[2].images.medium);
    });
  }

  @override
  Widget build(BuildContext context) {
    itemW = (MediaQuery.of(context).size.width - 30.0 - 20.0) / 3;

    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TodayPlayMovieWidget(todayUrls),
            ),
          ),
          SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                child: _getMovieItem(movies[index], itemW),
              );
            }, childCount: movies.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 377.0 / 674.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMovieItem(Subject movie, var itemW) {
    if (movie == null) {
      return Container();
    }
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: movie.id,
              child: MovieImage(
                movie.images.large,
                width: itemW,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  movie.title,
                  // 文本只显示一行
                  softWrap: false,
                  // 多出的文本渐隐方式
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Router.push(context, Router.detailPage, movie);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
