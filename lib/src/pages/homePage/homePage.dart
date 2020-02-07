import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/commonWidget/customWidget.dart';
import 'package:flutter_news_app/src/models/newsResponseModel.dart';
import 'package:flutter_news_app/src/pages/newsDetail/bloc/bloc.dart';
import 'package:flutter_news_app/src/theme/theme.dart';
import 'bloc/bloc.dart';
import 'widget/newsCard.dart';

class HomePage extends StatelessWidget {
  Widget _headerNews(Article article) {
    return Builder(
      builder: (context) {
        return InkWell(
            onTap: () {
              final detailBloc = BlocProvider.of<DetailBloc>(context);
              detailBloc.add(SelectNewsForDetail(article: article));
              Navigator.pushNamed(context, '/detail');
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Hero(
                  tag: 'headerImage',
                  child: customImage(article.urlToImage),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 10, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(article.title,
                          style: AppTheme.h1Style.copyWith(
                              color: Theme.of(context).backgroundColor)),
                      Text(article.getTime(),
                          style: AppTheme.subTitleStyle.copyWith(
                              color: Theme.of(context).backgroundColor))
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  Widget _body(BuildContext context, List<Article> list, {NewsState state}) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          title: Text(
            'NEWS',
            style: AppTheme.h2Style
                .copyWith(color: Theme.of(context).colorScheme.primaryVariant),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: _headerNews(list.first),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => NewsCard(artical: list[index]),
                childCount: list.length))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
            child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
          if (state == null) {
            return Center(child: Text('Null block'));
          }
          if (state is Failure) {
            return Center(child: Text('Something went wrong'));
          }
          if (state is Loaded) {
            if (state.items == null || state.items.isEmpty) {
              return Text('No content avilable');
            } else {
              return _body(
                context,
                state.items,
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        })));
  }
}
