import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expo/data/models/exhibition_model.dart';
//import 'package:expo/ui/app/dismissible_entity.dart';

class ExhibitionItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ExhibitionEntity exhibition;

  static final exhibitionItemKey =
      (String id) => Key('__exhibition_item_${id}__');

  ExhibitionItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.exhibition,
  });

  @override
  Widget build(BuildContext context) {
    /*
    return DismissibleEntity(
      entity: exhibition,
      onDismissed: onDismissed,
      onTap: onTap,
      child: ListTile(
        onTap: onTap,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  exhibition.displayName,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ],
          ),
        ),
subtitle: Text(exhibition.name, maxLines: 4),

      ),
    );
  }
  */

    return ListTile(
      onTap: onTap,
      title: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                exhibition.displayName,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(exhibition.name, maxLines: 4),
    );
  }
}
