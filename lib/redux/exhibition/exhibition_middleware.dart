import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:expo/ui/exhibition/exhibition_screen.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/redux/exhibition/exhibition_actions.dart';
import 'package:expo/redux/ui/ui_actions.dart';
import 'package:expo/ui/exhibition/edit/exhibition_edit_vm.dart';
import 'package:expo/ui/exhibition/view/exhibition_view_vm.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/data/repositories/exhibition_repository.dart';

List<Middleware<AppState>> createStoreExhibitionsMiddleware([
  ExhibitionRepository repository = const ExhibitionRepository(),
]) {
  final viewExhibitionList = _viewExhibitionList();
  final viewExhibition = _viewExhibition();
  final editExhibition = _editExhibition();
  final loadExhibitions = _loadExhibitions(repository);
  final saveExhibition = _saveExhibition(repository);
  final deleteExhibition = _deleteExhibition(repository);

  return [
    TypedMiddleware<AppState, ViewExhibitionList>(viewExhibitionList),
    TypedMiddleware<AppState, ViewExhibition>(viewExhibition),
    TypedMiddleware<AppState, EditExhibition>(editExhibition),
    TypedMiddleware<AppState, LoadExhibitions>(loadExhibitions),
    TypedMiddleware<AppState, SaveExhibitionRequest>(saveExhibition),
    TypedMiddleware<AppState, DeleteExhibitionRequest>(deleteExhibition),
  ];
}

Middleware<AppState> _viewExhibitionList() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(ExhibitionScreen.route));
    Navigator.of(action.context).pushReplacementNamed(ExhibitionScreen.route);
  };
}

Middleware<AppState> _viewExhibition() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(ExhibitionViewScreen.route));
    Navigator.of(action.context).pushNamed(ExhibitionViewScreen.route);
  };
}

Middleware<AppState> _editExhibition() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(ExhibitionEditScreen.route));
    Navigator.of(action.context).pushNamed(ExhibitionEditScreen.route);
  };
}


Middleware<AppState> _deleteExhibition(ExhibitionRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    var origExhibition = store.state.exhibitionState.map[action.exhibitionId];
    repository
        .saveData(store.state.authState,
            origExhibition, EntityAction.delete)
        .then((exhibition) {
      store.dispatch(DeleteExhibitionSuccess(exhibition));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((error) {
      print(error);
      store.dispatch(DeleteExhibitionFailure(origExhibition));
    });

    next(action);
  };
}

Middleware<AppState> _saveExhibition(ExhibitionRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository
        .saveData(
            store.state.authState, action.exhibition)
        .then((exhibition) {
      if (action.exhibition.isNew) {
        store.dispatch(AddExhibitionSuccess(exhibition));
      } else {
        store.dispatch(SaveExhibitionSuccess(exhibition));
      }
      action.completer.complete(null);
    }).catchError((error) {
      print(error);
      store.dispatch(SaveExhibitionFailure(error));
    });

    next(action);
  };
}

Middleware<AppState> _loadExhibitions(ExhibitionRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    AppState state = store.state;

    if (!state.exhibitionState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadExhibitionsRequest());
    repository
        .loadList(state.authState)
        .then((data) {
      store.dispatch(LoadExhibitionsSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((error) {
      print(error);
      store.dispatch(LoadExhibitionsFailure(error));
    });

    next(action);
  };
}
