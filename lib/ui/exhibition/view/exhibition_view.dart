import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expo/ui/app/actions_menu_button.dart';
import 'package:expo/ui/exhibition/view/exhibition_view_vm.dart';
import 'package:expo/ui/app/form_card.dart';

class ExhibitionView extends StatefulWidget {
  final ExhibitionViewVM viewModel;

  ExhibitionView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _ExhibitionViewState createState() => new _ExhibitionViewState();
}

class _ExhibitionViewState extends State<ExhibitionView> {
  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;
    var exhibition = viewModel.exhibition;

    return Scaffold(
      appBar: AppBar(
        title: Text(exhibition.displayName),
        actions: exhibition.isNew
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
                  entity: exhibition,
                  onSelected: viewModel.onActionSelected,
                )
              ],
      ),
      body: FormCard(children: [
        Text(exhibition.id, style: Theme.of(context).textTheme.title),
        SizedBox(height: 12.0),
        Text(exhibition.name),
        Text(exhibition.description),
        Text(exhibition.photos.toString()),
        Text(exhibition.votes.toString()),
      ]),
    );
  }
}
