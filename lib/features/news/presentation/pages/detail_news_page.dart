import 'dart:convert';

import 'package:covid_statistics/core/utils/app_colors.dart';
import 'package:covid_statistics/core/utils/view.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';

class DetailNewsPage extends StatelessWidget {
  final News news;
  const DetailNewsPage({Key? key, required this.news}) : super(key: key);

  Widget _image() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 3,
          ),
        ],
        image: DecorationImage(
          image: MemoryImage(base64.decode(news.base64Image!)),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _title() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: View.y * 5,
        ),
        padding: EdgeInsets.only(
          left: View.x * 5,
          right: View.x * 5,
        ),
        child: Text(
          news.title!,
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
          news.pubDate!,
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
          data: news.description,
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

  Widget _appBar() {
    return SliverAppBar(
      expandedHeight: View.x * 80,
      flexibleSpace: _image(),
    );
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Container(
      color: darkblue.withOpacity(0.5),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: [
              _appBar(),
              _title(),
              _dateTime(),
              _content(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: black,
            onPressed: () async => await Share.share(
                '${news.title!} , selengkapnya baca di ${news.link}'),
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
