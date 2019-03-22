import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expo/data/models/user_model.dart';
//import 'package:expo/ui/app/dismissible_entity.dart';

class UserItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final UserEntity user;

  static final userItemKey = (String id) => Key('__user_item_${id}__');

  UserItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    /*
    return DismissibleEntity(
      entity: user,
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
                  user.displayName,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ],
          ),
        ),
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
                user.displayName,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
