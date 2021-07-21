import 'package:carousel_slider/carousel_slider.dart';
import '../../../../repository/rss_news.dart';
import 'detail_news_page.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/view.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  RssFeed rssFeed = RssFeed();

  int getWordMinute(String words) {
    var regExp = RegExp('[^0-9A-Z,\n]', caseSensitive: false, multiLine: true);
    int count = regExp.allMatches(words).length;
    int readingSpeed = 300;
    return (count / readingSpeed).round();
  }

  void getNews() async {
    var result = await RssNews().getNews();
    setState(() => rssFeed = result);
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Widget _title() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(View.x * 5),
        child: Text(
          'Berita terkini',
          style: TextStyle(
            color: Colors.white,
            fontSize: View.x * 6,
          ),
        ),
      ),
    );
  }

  Widget _carouselNewsItem({RssItem rssItem}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(View.x * 2),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    offset: Offset(3, 3),
                  )
                ],
                image: DecorationImage(
                  image: NetworkImage(rssItem.enclosure.url),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(View.x * 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rssItem.title,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${getWordMinute(rssItem.description)} min bacaan',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _carouselNews() {
    return rssFeed.items.length == 0
        ? SliverToBoxAdapter(
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : SliverToBoxAdapter(
            child: Container(
              width: View.x * 100,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: View.y * 35,
                  viewportFraction: 0.9,
                  autoPlay: true,
                ),
                items: [
                  _carouselNewsItem(rssItem: rssFeed.items[0]),
                  _carouselNewsItem(rssItem: rssFeed.items[1]),
                  _carouselNewsItem(rssItem: rssFeed.items[2]),
                ],
              ),
            ),
          );
  }

  Widget _recomendation() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(
          left: View.x * 5,
          bottom: View.x * 4,
        ),
        child: Text(
          'Rekomendasi',
          style: TextStyle(
            color: Colors.white,
            fontSize: View.x * 4,
          ),
        ),
      ),
    );
  }

  Widget _newsListItem({RssItem rssItem}) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailNewsPage(
            rssItem: rssItem,
          ),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            bottom: View.x * 4, left: View.x * 5, right: View.x * 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(View.x * 5),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(View.x * 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(View.x * 3),
                    bottomLeft: Radius.circular(View.x * 3),
                  ),
                  color: black,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      offset: Offset(3, 3),
                    )
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(View.x * 3),
                    image: DecorationImage(
                      image: NetworkImage(rssItem.enclosure.url),
                      fit: BoxFit.fill,
                    ),
                    color: black,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(View.x * 3),
                    bottomRight: Radius.circular(View.x * 3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      offset: Offset(3, 3),
                    )
                  ],
                  color: black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        right: View.x * 3,
                      ),
                      child: Text(
                        rssItem.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: View.x * 4,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      child: Text(
                        '${getWordMinute(rssItem.description)} min bacaan',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: View.x * 3.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _newsList() {
    return rssFeed.items.length == 0
        ? SliverToBoxAdapter(
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : SliverFixedExtentList(
            itemExtent: View.y * 20,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _newsListItem(rssItem: rssFeed.items[index]);
              },
              childCount: rssFeed.items.length,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkblue,
      child: CustomScrollView(
        slivers: [
          _title(),
          _carouselNews(),
          _recomendation(),
          _newsList(),
        ],
      ),
    );
  }
}
