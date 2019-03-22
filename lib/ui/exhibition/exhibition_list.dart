import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expo/ui/exhibition/exhibition_item.dart';
import 'package:expo/ui/exhibition/exhibition_list_vm.dart';

class ExhibitionList extends StatelessWidget {
  final ExhibitionListVM viewModel;

  ExhibitionList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (! viewModel.isLoaded) {
      return Center(child: CircularProgressIndicator());
    }

    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.exhibitionList.length,
          itemBuilder: (BuildContext context, index) {
            var exhibitionId = viewModel.exhibitionList[index];
            var exhibition = viewModel.exhibitionMap[exhibitionId];
            return Column(children: <Widget>[
              ExhibitionItem(
                exhibition: exhibition,
                onDismissed: (DismissDirection direction) =>
                    viewModel.onDismissed(context, exhibition, direction),
                onTap: () => viewModel.onExhibitionTap(context, exhibition),
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}
