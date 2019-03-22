import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expo/redux/ui/ui_actions.dart';
import 'package:expo/ui/exhibition/exhibition_screen.dart';
import 'package:redux/redux.dart';
import 'package:expo/redux/exhibition/exhibition_actions.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/ui/exhibition/edit/exhibition_edit.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/ui/app/icon_message.dart';

class ExhibitionEditScreen extends StatelessWidget {
  static final String route = '/exhibition/edit';
  ExhibitionEditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExhibitionEditVM>(
      converter: (Store<AppState> store) {
        return ExhibitionEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return ExhibitionEdit(
          viewModel: vm,
        );
      },
    );
  }
}

class ExhibitionEditVM {
  final ExhibitionEntity exhibition;
  final Function(ExhibitionEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;
  final bool isLoading;

  ExhibitionEditVM({
    @required this.exhibition,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onBackPressed,
    @required this.isLoading,
  });

  factory ExhibitionEditVM.fromStore(Store<AppState> store) {
    final exhibition = store.state.exhibitionUIState.selected;

    return ExhibitionEditVM(
      isLoading: store.state.isLoading,
      exhibition: exhibition,
      onChanged: (ExhibitionEntity exhibition) {
        store.dispatch(UpdateExhibition(exhibition));
      },
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(ExhibitionScreen.route));
      },
      onSavePressed: (BuildContext context) {
        final Completer<Null> completer = new Completer<Null>();
        store.dispatch(SaveExhibitionRequest(completer: completer, exhibition: exhibition));
        return completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: IconMessage(
                message: exhibition.isNew
                    ? 'Successfully Created Exhibition'
                    : 'Successfully Updated Exhibition',
              ),
              duration: Duration(seconds: 3)));
        });
      },
    );
  }
}
