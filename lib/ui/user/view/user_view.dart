import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expo/ui/app/actions_menu_button.dart';
import 'package:expo/ui/user/view/user_view_vm.dart';
import 'package:expo/ui/app/form_card.dart';

class UserView extends StatefulWidget {
  final UserViewVM viewModel;

  UserView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _UserViewState createState() => new _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;
    var user = viewModel.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName),
        actions: user.isNew
            ? []
            : [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    viewModel.onEditPressed(context);
                  },
                ),
                ActionMenuButton(
                  isLoading: viewModel.isLoading,
                  entity: user,
                  onSelected: viewModel.onActionSelected,
                )
              ],
      ),
      body: FormCard(children: [
        Text(user.id, style: Theme.of(context).textTheme.title),
        SizedBox(height: 12.0),
      ]),
    );
  }
}
