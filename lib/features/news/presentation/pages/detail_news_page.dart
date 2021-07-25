import 'package:covid_statistics/core/utils/app_colors.dart';
import 'package:covid_statistics/core/utils/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webfeed/domain/rss_item.dart';

class DetailNewsPage extends StatelessWidget {
  final RssItem? rssItem;
  const DetailNewsPage({Key? key, this.rssItem}) : super(key: key);

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
            image: NetworkImage(rssItem!.enclosure!.url!),
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
          rssItem!.title!,
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
          rssItem!.pubDate!,
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
        padding: EdgeInsets.only(left: View.x * 4, right: View.x * 4),
        child: Html(
          data: rssItem!.description,
          style: {
            "p": Style(
              color: Colors.white,
              textAlign: TextAlign.justify,
            )
          },
        ),
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: black,
            onPressed: () async => await Share.share(
                '${rssItem!.title} , selengkapnya baca di ${rssItem!.link}'),
            child: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
