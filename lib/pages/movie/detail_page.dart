import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_app/common/config/API.dart';
import 'package:video_app/components/image/movie_image.dart';
import 'package:video_app/model/subject_entity.dart';
import 'package:like_button/like_button.dart';
import 'package:video_player/video_player.dart';
import 'package:video_app/model/movie_detail_bean.dart';

final API _api = API();

class DetailPage extends StatefulWidget {
  final Subject subject;

  DetailPage(this.subject, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState(subject);
  }
}

class _DetailPageState extends State<DetailPage> {
  VideoPlayerController _controller;
  final Subject subject;
  MovieDetailBean movie;

  _DetailPageState(this.subject);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network("");
    _api.getMovieDetail(subject.id, (result) {
      movie = result;
      _controller = VideoPlayerController.network(movie.blooper_urls[0])
        ..initialize().then((_) {
          setState(() {});
        })
        ..play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          subject.title,
          style: new TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Hero(
                tag: subject.id,
                child: MovieImage(subject.images.large,
                    width: MediaQuery.of(context).size.width / 3),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: movie != null
                ? Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, top: 10.0, right: 20.0, bottom: 80.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "${subject.year}年  /  ${movie.languages}  /  ${subject.durations[0]}",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            "        ${movie.summary}",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        _videoView(),
                      ],
                    ),
                  )
                : Center(
                    child: CupertinoActivityIndicator(),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Increment',
        child: LikeButton(),
      ),
    );
  }

  Widget _videoView() {
    return _controller.value.initialized
        ? Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              Positioned(
                  bottom: 10.0,
                  right: 10.0,
                  child: GestureDetector(
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    onTap: () {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    },
                  ))
            ],
          )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
