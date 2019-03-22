import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expo/redux/exhibition/exhibition_actions.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/ui/exhibition/view/exhibition_view.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/ui/app/icon_message.dart';

class ExhibitionViewScreen extends StatelessWidget {
  static final String route = '/exhibition/view';
  ExhibitionViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExhibitionViewVM>(
      converter: (Store<AppState> store) {
        return ExhibitionViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ExhibitionView(
          viewModel: vm,
        );
      },
    );
  }
}

class ExhibitionViewVM {
  final ExhibitionEntity exhibition;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext) onEditPressed;
  final bool isLoading;

  ExhibitionViewVM({
    @required this.exhibition,
    @required this.onActionSelected,
    @required this.onEditPressed,
    @required this.isLoading,
  });

  factory ExhibitionViewVM.fromStore(Store<AppState> store) {
    final exhibition = store.state.exhibitionUIState.selected;

    return ExhibitionViewVM(
        isLoading: store.state.isLoading,
        exhibition: exhibition,
        onEditPressed: (BuildContext context) {
          store.dispatch(EditExhibition(exhibition: exhibition, context: context));
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final Completer<Null> completer = new Completer<Null>();
          var message;
          switch (action) {
            case EntityAction.delete:
              store.dispatch(DeleteExhibitionRequest(completer, exhibition.id));
              message = 'Successfully Deleted Exhibition';
              break;
          }
          if (message != null) {
            return completer.future.then((_) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: IconMessage(
                    message: message,
                  ),
                  duration: Duration(seconds: 3)));
            });
          }
        }
    );
  }
}
