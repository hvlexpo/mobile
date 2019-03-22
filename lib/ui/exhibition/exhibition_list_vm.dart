import 'dart:async';
import 'package:redux/redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expo/redux/exhibition/exhibition_selectors.dart';
import 'package:expo/ui/app/icon_message.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/ui/exhibition/exhibition_list.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/redux/exhibition/exhibition_actions.dart';

class ExhibitionListBuilder extends StatelessWidget {
  static final String route = '/exhibitions/edit';
  ExhibitionListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExhibitionListVM>(
      converter: ExhibitionListVM.fromStore,
      builder: (context, vm) {
        return ExhibitionList(
          viewModel: vm,
        );
      },
    );
  }
}

class ExhibitionListVM {
  final List<String> exhibitionList;
  final BuiltMap<String, ExhibitionEntity> exhibitionMap;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, ExhibitionEntity) onExhibitionTap;
  final Function(BuildContext, ExhibitionEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;

  ExhibitionListVM({
    @required this.exhibitionList,
    @required this.exhibitionMap,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onExhibitionTap,
    @required this.onDismissed,
    @required this.onRefreshed,
  });

  static ExhibitionListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      final Completer<Null> completer = new Completer<Null>();
      store.dispatch(LoadExhibitions(completer, true));
      return completer.future.then((_) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: IconMessage(
              message: 'Refresh complete',
            ),
            duration: Duration(seconds: 3)));
      });
    }

    return ExhibitionListVM(
        exhibitionList: memoizedExhibitionList(store.state.exhibitionState.map,
            store.state.exhibitionState.list, store.state.exhibitionListState),
        exhibitionMap: store.state.exhibitionState.map,
        isLoading: store.state.isLoading,
        isLoaded: store.state.exhibitionState.isLoaded,
        onExhibitionTap: (context, exhibition) {
          store.dispatch(ViewExhibition(exhibition: exhibition, context: context));
        },
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, ExhibitionEntity exhibition,
            DismissDirection direction) {
          final Completer<Null> completer = new Completer<Null>();
          store.dispatch(DeleteExhibitionRequest(completer, exhibition.id));
          var message = 'Successfully Deleted Exhibition';
          return completer.future.then((_) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: IconMessage(
                  message: message,
                ),
                duration: Duration(seconds: 3)));
          });
        });
  }
}
