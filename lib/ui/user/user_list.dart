import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expo/ui/user/user_item.dart';
import 'package:expo/ui/user/user_list_vm.dart';

class UserList extends StatelessWidget {
  final UserListVM viewModel;

  UserList({
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
          itemCount: viewModel.userList.length,
          itemBuilder: (BuildContext context, index) {
            var userId = viewModel.userList[index];
            var user = viewModel.userMap[userId];
            return Column(children: <Widget>[
              UserItem(
                user: user,
                onDismissed: (DismissDirection direction) =>
                    viewModel.onDismissed(context, user, direction),
                onTap: () => viewModel.onUserTap(context, user),
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}
