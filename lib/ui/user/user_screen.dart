import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expo/ui/app/app_search.dart';
import 'package:expo/ui/app/app_search_button.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/ui/user/user_list_vm.dart';
import 'package:expo/redux/user/user_actions.dart';
import 'package:expo/ui/app/app_drawer_vm.dart';
import 'package:expo/ui/app/app_bottom_bar.dart';

class UserScreen extends StatelessWidget {
  static final String route = '/user';

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: AppSearch(
          entityType: EntityType.user,
          onSearchChanged: (value) {
            store.dispatch(SearchUsers(value));
          },
        ),
        actions: [
          AppSearchButton(
            entityType: EntityType.user,
            onSearchPressed: (value) {
              store.dispatch(SearchUsers(value));
            },
          ),
        ],
      ),
      drawer: AppDrawerBuilder(),
      body: UserListBuilder(),
      bottomNavigationBar: AppBottomBar(
        entityType: EntityType.user,
        onSelectedSortField: (value) {
          store.dispatch(SortUsers(value));
        },
        sortFields: [
          UserFields.id,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          store.dispatch(EditUser(user: UserEntity(), context: context));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: 'New User',
      ),
    );
  }
}
