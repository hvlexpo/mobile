import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expo/ui/exhibitions/exhibition_photo_tab.dart';
import 'package:expo/ui/exhibitions/exhibition_about_tab.dart';
import 'package:expo/ui/exhibitions/exhibition_creator_tab.dart';
import 'package:expo/data/repositories/exhibition_repository.dart';
import 'package:expo/data/repositories/user_repository.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expo/ui/theme/theme.dart';

class ExhibitionDefaultView extends StatelessWidget {
  final ExhibitionEntity exhibition;
  final ExhibitionRepository exhibitionRepository = ExhibitionRepository();
  final UserRepository userRepisitory = UserRepository();
  final bool votable;

  ExhibitionDefaultView(this.exhibition, {this.votable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, scrolling) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  width: 250,
                  child: AutoSizeText(exhibition.name),
                ),
                titlePadding: EdgeInsets.symmetric(vertical: 10),
                background: Container(
                  foregroundDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: exhibition.photos.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              actions: [
                votable
                    ? FlatButton.icon(
                        icon: Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Vote',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async => showDialog(
                            context: context,
                            builder: (context) {
                              return FutureBuilder<List<Map<String, dynamic>>>(
                                future: userRepisitory.fetchUserVotes(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final vote = snapshot.data.firstWhere((i) =>
                                        i['exhibition_id'] == exhibition.id);
                                    final weight = int.parse(vote['weight']);
                                    return Center(
                                      child: Container(
                                        height: 250,
                                        width: 500,
                                        child: Card(
                                          child: Center(
                                            child: Row(
                                                children: [0, 1, 2, 3, 4, 5]
                                                    .map((index) {
                                              return IconButton(
                                                icon: Icon(
                                                  Icons.star,
                                                  color: (index < weight)
                                                      ? Colors.yellow
                                                      : Colors.white,
                                                ),
                                                onPressed: () async =>
                                                    exhibitionRepository.vote(
                                                        exhibition.id, index),
                                              );
                                            }).toList()),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              );
                            }),
                      )
                    : Container()
              ],
            ),
          ];
        },
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(child: _buildContent(constraints));
                    },
                  ),
                ),
                _buildTabBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar({bool showFirstOption}) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          bottom: null,
          child: Container(
            height: 1,
            color: Colors.black12,
          ),
        ),
        TabBar(
          indicatorWeight: 2,
          indicatorColor: ExpoColors.hvlAccent,
          tabs: <Widget>[
            Tab(text: 'About'),
            Tab(text: 'Creators'),
            Tab(text: 'Photos'),
          ],
          labelColor: Colors.black45,
          unselectedLabelColor: Colors.grey,
        )
      ],
    );
  }

  Widget _buildContent(BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight / 1.5,
      width: constraints.maxWidth,
      child: TabBarView(
        children: [
          AboutTab(exhibition),
          CreatorTab(exhibition),
          PhotoTab(exhibition.photos)
        ],
      ),
    );
  }
}
