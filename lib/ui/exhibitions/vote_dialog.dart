import 'package:flutter/material.dart';
import 'package:expo/data/repositories/exhibition_repository.dart';
import 'package:expo/data/repositories/user_repository.dart';
import 'package:expo/data/models/exhibition_model.dart';

class VoteDialog extends StatefulWidget {
  final ExhibitionEntity exhibition;

  VoteDialog(BuildContext context, this.exhibition);

  @override
  _VoteDialogState createState() => _VoteDialogState();
}

class _VoteDialogState extends State<VoteDialog> {
  final exhibitionRepository = ExhibitionRepository();
  final userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: userRepository.fetchUserVotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int weight;
          if (snapshot.data != null && snapshot.data.isNotEmpty) {
            final vote = snapshot.data.firstWhere(
                (i) => i['exhibition_id'] == widget.exhibition.id,
                orElse: () => {'weight': '0'});
            weight = int.parse(vote['weight']);
          } else {
            weight = 0;
          }
          return Center(
            child: Container(
              height: 250,
              width: 500,
              child: Card(
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [1, 2, 3, 4, 5].map((index) {
                        return IconButton(
                            icon: Icon(
                              Icons.star,
                              color: (index <= weight)
                                  ? Colors.yellow
                                  : Colors.black12,
                            ),
                            onPressed: () async {
                              await exhibitionRepository.vote(
                                  widget.exhibition.id, index.toString());
                                  setState(() {});
                            });
                      }).toList()),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
