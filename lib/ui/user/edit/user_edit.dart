import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expo/ui/app/form_card.dart';
import 'package:expo/ui/user/edit/user_edit_vm.dart';
import 'package:expo/ui/app/save_icon_button.dart';

class UserEdit extends StatefulWidget {
  final UserEditVM viewModel;

  UserEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();

  var _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _idController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    var user = widget.viewModel.user;
    _idController.text = user.id;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  _onChanged() {
    var user =
        widget.viewModel.user.rebuild((b) => b..id = _idController.text.trim());
    if (user != widget.viewModel.user) {
      widget.viewModel.onChanged(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              viewModel.user.isNew ? 'New User' : viewModel.user.displayName),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return SaveIconButton(
                isLoading: viewModel.isLoading,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  viewModel.onSavePressed(context);
                },
              );
            }),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  TextFormField(
                    controller: _idController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Id',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
