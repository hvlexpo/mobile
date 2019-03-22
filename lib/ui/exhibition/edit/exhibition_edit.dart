import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expo/ui/app/form_card.dart';
import 'package:expo/ui/exhibition/edit/exhibition_edit_vm.dart';
import 'package:expo/ui/app/save_icon_button.dart';

class ExhibitionEdit extends StatefulWidget {
  final ExhibitionEditVM viewModel;

  ExhibitionEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _ExhibitionEditState createState() => _ExhibitionEditState();
}

class _ExhibitionEditState extends State<ExhibitionEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();

  final _nameController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _photosController = TextEditingController();

  final _votesController = TextEditingController();

  var _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _idController,
      _nameController,
      _descriptionController,
      _photosController,
      _votesController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    var exhibition = widget.viewModel.exhibition;
    _idController.text = exhibition.id;

    _nameController.text = exhibition.name;

    _descriptionController.text = exhibition.description;

    _photosController.text = exhibition.photos.toString();

    _votesController.text = exhibition.votes.toString();

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
    var exhibition = widget.viewModel.exhibition.rebuild((b) => b
      ..id = _idController.text.trim()
      ..name = _nameController.text.trim()
      ..description = _descriptionController.text.trim());
    if (exhibition != widget.viewModel.exhibition) {
      widget.viewModel.onChanged(exhibition);
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
          title: Text(viewModel.exhibition.isNew
              ? 'New Exhibition'
              : viewModel.exhibition.displayName),
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
                  TextFormField(
                    controller: _nameController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  TextFormField(
                    controller: _photosController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Photos',
                    ),
                  ),
                  TextFormField(
                    controller: _votesController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Votes',
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
