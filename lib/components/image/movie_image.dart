import 'package:flutter/material.dart';
import 'cached_network_image.dart';

class MovieImage extends StatefulWidget {
  final imgNetUrl;
  var height;
  final width;

  MovieImage(this.imgNetUrl, {Key key, this.width = 150.0}) : super(key: key);

  @override
  _MovieImageState createState() {
    height = this.width / 150.0 * 210.0;
    return _MovieImageState(imgNetUrl, height, width);
  }
}

class _MovieImageState extends State<MovieImage> {
  String imgNetUrl;
  var imgWH = 28.0;
  var height;
  var width;
  var loadImg;

  _MovieImageState(this.imgNetUrl, this.height, this.width);

  @override
  void initState() {
    super.initState();
    loadImg = ClipRRect(
      child: CachedNetworkImage(
        imageUrl: imgNetUrl,
        width: width,
        height: height,
        fit: BoxFit.fill,
        fadeInDuration: const Duration(milliseconds: 80),
        fadeOutDuration: const Duration(milliseconds: 80),
      ),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadImg,
      ],
    );
  }
}
