import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expo/ui/exhibitions/exhibition_photo_tab.dart';
import 'package:expo/ui/theme/theme.dart';

class ExhibitionDefaultView extends StatelessWidget {
  final ExhibitionEntity exhibition;

  ExhibitionDefaultView(this.exhibition);

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
                  title: Text(exhibition.name),
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
          )),
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
            Tab(text: 'Creator'),
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
        children: [Text('Yeet'), Text('Skeet'), PhotoTab(exhibition.photos)],
      ),
    );
  }
}
