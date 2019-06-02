import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_app/pages/main/page_main.dart';
import 'package:video_app/pages/movie/detail_page.dart';
import 'package:video_app/pages/web_view_page.dart';

///https://www.jianshu.com/p/b9d6ec92926f

class Router {
  static const homePage = 'app://';
  static const detailPage = 'app://DetailPage';

//  Widget _getPage(String url, dynamic params) {
//    if (url.startsWith('https://') || url.startsWith('http://')) {
//      return WebViewPage(url, params: params);
//    } else {
//      switch (url) {
//        case detailPage:
//          return DetailPage(params);
//        case homePage:
//          return MainPage();
//      }
//    }
//    return null;
//  }

  Widget _getPage(String url, dynamic params) {
    switch (url) {
      case detailPage:
        return DetailPage(params);
      case homePage:
        return MainPage();
    }
  }

  Router.pushNoParams(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    }));
  }

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
