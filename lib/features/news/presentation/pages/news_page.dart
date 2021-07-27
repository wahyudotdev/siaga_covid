import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_statistics/core/utils/app_colors.dart';
import 'package:covid_statistics/core/utils/view.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:covid_statistics/features/news/presentation/bloc/news_bloc.dart';
import 'package:covid_statistics/features/news/presentation/pages/detail_news_page.dart';
import 'package:covid_statistics/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  final _bloc = sl<NewsBloc>();
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

  Widget _carouselNewsItem({required News news}) {
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
                  image: MemoryImage(base64.decode(news.base64Image!)),
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
                    news.title!,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${news.minuteReading} min bacaan',
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

  // ignore: unused_element
  Widget _carouselNews() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsInitial) {
          _bloc.add(GetAllNewsEvent());
        }
        if (state is LoadedAllNews) {
          return SliverToBoxAdapter(
            child: Container(
              width: View.x * 100,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: View.y * 35,
                  viewportFraction: 0.9,
                  autoPlay: true,
                ),
                items:
                    state.news.map((e) => _carouselNewsItem(news: e)).toList(),
              ),
            ),
          );
        }
        return SliverToBoxAdapter(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // ignore: unused_element
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

  Widget _newsListItem({required News news, required BuildContext context}) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailNewsPage(news: news))),
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
                      image: MemoryImage(base64.decode(news.base64Image!)),
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
                        news.title!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: View.x * 4,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      child: Text(
                        '${news.minuteReading} min bacaan',
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

  // ignore: unused_element
  Widget _newsList() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is LoadedAllNews) {
          return SliverFixedExtentList(
            itemExtent: View.y * 20,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _newsListItem(news: state.news[index], context: context);
              },
              childCount: state.news.length,
            ),
          );
        }
        return SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsBloc>(
      create: (context) => _bloc,
      child: Container(
        color: darkblue,
        child: CustomScrollView(
          slivers: [
            _title(),
            _carouselNews(),
            _recomendation(),
            _newsList(),
          ],
        ),
      ),
    );
  }
}
