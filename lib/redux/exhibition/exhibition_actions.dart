import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/redux/app/app_actions.dart';


class ViewExhibitionList implements PersistUI {
  final BuildContext context;
  ViewExhibitionList(this.context);
}

class ViewExhibition implements PersistUI {
  final ExhibitionEntity exhibition;
  final BuildContext context;
  ViewExhibition({this.exhibition, this.context});
}

class EditExhibition implements PersistUI {
  final ExhibitionEntity exhibition;
  final BuildContext context;
  EditExhibition({this.exhibition, this.context});
}


class LoadExhibitions {
  final Completer completer;
  final bool force;

  LoadExhibitions([this.completer, this.force = false]);
}

class LoadExhibitionsRequest implements StartLoading {}

class LoadExhibitionsFailure implements StopLoading {
  final dynamic error;
  LoadExhibitionsFailure(this.error);

  @override
  String toString() {
    return 'LoadExhibitionsFailure{error: $error}';
  }
}

class LoadExhibitionsSuccess implements StopLoading, PersistData {
  final BuiltList<ExhibitionEntity> exhibitions;
  LoadExhibitionsSuccess(this.exhibitions);

  @override
  String toString() {
    return 'LoadExhibitionsSuccess{exhibitions: $exhibitions}';
  }
}


class UpdateExhibition implements PersistUI {
  final ExhibitionEntity exhibition;
  UpdateExhibition(this.exhibition);
}

class SaveExhibitionRequest implements StartLoading {
  final Completer completer;
  final ExhibitionEntity exhibition;
  SaveExhibitionRequest({this.completer, this.exhibition});
}

class AddExhibitionSuccess implements StopLoading, PersistData {
  final ExhibitionEntity exhibition;
  AddExhibitionSuccess(this.exhibition);
}


class SaveExhibitionSuccess implements StopLoading, PersistData {
  final ExhibitionEntity exhibition;

  SaveExhibitionSuccess(this.exhibition);
}

class SaveExhibitionFailure implements StopLoading {
  final String error;
  SaveExhibitionFailure (this.error);
}

class DeleteExhibitionRequest implements StartLoading {
  final Completer completer;
  final String exhibitionId;

  DeleteExhibitionRequest(this.completer, this.exhibitionId);
}

class DeleteExhibitionSuccess implements StopLoading, PersistData {
  final ExhibitionEntity exhibition;
  DeleteExhibitionSuccess(this.exhibition);
}

class DeleteExhibitionFailure implements StopLoading {
  final ExhibitionEntity exhibition;
  DeleteExhibitionFailure(this.exhibition);
}



class SearchExhibitions {
  final String search;
  SearchExhibitions(this.search);
}

class SortExhibitions implements PersistUI {
  final String field;
  SortExhibitions(this.field);
}
