import 'package:covid_statistics/ui/widgets/app_colors.dart';
import 'package:covid_statistics/ui/widgets/view.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';

class DetailNewsPage extends StatelessWidget {
  final RssItem rssItem;
  const DetailNewsPage({Key key, this.rssItem}) : super(key: key);

  Widget _image() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(View.x * 5),
        width: double.infinity,
        height: View.y * 30,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(View.x * 3),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 3,
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(rssItem.enclosure.url),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: View.x * 5,
          right: View.x * 5,
        ),
        child: Text(
          rssItem.title,
          style: TextStyle(color: Colors.white, fontSize: View.x * 5),
        ),
      ),
    );
  }

  Widget _dateTime() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(View.x * 5),
        child: Text(
          rssItem.pubDate,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        // child: ,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Container(
      color: darkblue,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: darkblue,
          body: CustomScrollView(
            slivers: [
              _image(),
              _title(),
              _dateTime(),
              _content(),
            ],
          ),
        ),
      ),
    );
  }
}
