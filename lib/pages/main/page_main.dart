import 'package:flutter/material.dart';
import 'package:video_app/components/theme/theme.dart';

import 'package:video_app/pages/movie/movie_page.dart';
import '../../my_homepage2.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _tabIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProxyAnimation transitionAnimation =
      ProxyAnimation(kAlwaysDismissedAnimation);

  _tabChangeListener() {
    setState(() {
      _tabIndex = _tabController.index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_tabChangeListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabChangeListener);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalTheme.of(context).setTheme(_tabIndex);

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            _AppDrawerHeader(),
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Expanded(
                  child: ListTileTheme(
                    style: ListTileStyle.drawer,
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.android),
                          title: Text("演出"),
                        ),
                        Divider(height: 0, indent: 10),
                        ListTile(
                          leading: Icon(Icons.add_shopping_cart),
                          title: Text("商城"),
                        ),
                        ListTile(
                          leading: Icon(Icons.accessibility_new),
                          title: Text("附近的人"),
                        ),
                        ListTile(
                          leading: Icon(Icons.build),
                          title: Text("主题"),
//                          onTap: () {
//                            Navigator.pushNamed(context, ROUTE_SETTING);
//                          },
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              color: Theme.of(context).primaryIconTheme.color,
              progress: transitionAnimation),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: Container(
          height: kToolbarHeight,
          width: 160,
          child: TabBar(
            controller: _tabController,
            indicator:
                UnderlineTabIndicator(insets: EdgeInsets.only(bottom: 4)),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Tab>[
              Tab(
                child: Text(
                  '电影',
                  style: TextStyle(fontSize: _tabIndex == 0 ? 20 : 16),
                ),
              ),
              Tab(
                child: Text(
                  '音乐',
                  style: TextStyle(fontSize: _tabIndex == 1 ? 20 : 16),
                ),
              ),
            ],
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          MoviePage(),
          MyHomePage2(
            title: 'bbb',
          ),
        ],
      ),
    );
  }
}

class _AppDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildHeaderNotLogin(context);
  }

  Widget _buildHeaderNotLogin(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.black12),
      child: Container(
        constraints: BoxConstraints.expand(),
        child: DefaultTextStyle(
          style:
              Theme.of(context).primaryTextTheme.caption.copyWith(fontSize: 12),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("登陆网易云音乐", style: TextStyle(color: Colors.black)),
                Padding(padding: EdgeInsets.only(bottom: 6)),
                Text("手机电脑多端同步,尽享海量高品质音乐",
                    style: TextStyle(color: Colors.black)),
                Padding(padding: EdgeInsets.only(bottom: 10)),
                SizedBox(height: 8),
                FlatButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    onPressed: () {},
                    textColor: Colors.black,
                    child: Text("立即登陆"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
