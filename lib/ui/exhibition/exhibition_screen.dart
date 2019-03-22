import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expo/ui/app/app_search.dart';
import 'package:expo/ui/app/app_search_button.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/ui/exhibition/exhibition_list_vm.dart';
import 'package:expo/redux/exhibition/exhibition_actions.dart';
import 'package:expo/ui/app/app_drawer_vm.dart';
import 'package:expo/ui/app/app_bottom_bar.dart';

class ExhibitionScreen extends StatelessWidget {
  static final String route = '/exhibition';

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: AppSearch(
          entityType: EntityType.exhibition,
          onSearchChanged: (value) {
            store.dispatch(SearchExhibitions(value));
          },
        ),
        actions: [
          AppSearchButton(
            entityType: EntityType.exhibition,
            onSearchPressed: (value) {
              store.dispatch(SearchExhibitions(value));
            },
          ),
        ],
      ),
      drawer: AppDrawerBuilder(),
      body: ExhibitionListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.exhibition,
        onSelectedSortField: (value) {
          store.dispatch(SortExhibitions(value));
        },
        sortFields: [
          ExhibitionFields.id,
          ExhibitionFields.name,
          ExhibitionFields.description,
          ExhibitionFields.photos,
          ExhibitionFields.votes,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          store.dispatch(
              EditExhibition(exhibition: ExhibitionEntity(), context: context));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: 'New Exhibition',
      ),
    );
  }
}
