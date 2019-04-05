import 'package:flutter/material.dart';
import 'package:expo/data/repositories/exhibition_repository.dart';
import 'package:expo/ui/theme/theme.dart';
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
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Give your vote',
                      style: TextStyle(
                        color: ExpoColors.hvlAccent,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [1, 2, 3, 4, 5].map((index) {
                        return IconButton(
                            icon: Icon(
                              Icons.star,
                              color: (index <= weight)
                                  ? Colors.yellow
                                  : Colors.black12,
                              size: (index <= weight) ? 28 : 18,
                            ),
                            onPressed: () async {
                              await exhibitionRepository.vote(
                                  widget.exhibition.id, index.toString());
                              setState(() {});
                            });
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton.icon(
                      icon: Icon(
                        Icons.remove,
                        color: Colors.black26,
                      ),
                      label: Text(
                        'Remove my vote',
                        style: TextStyle(color: Colors.black26),
                      ),
                      onPressed: () async => exhibitionRepository
                          .removeVote(widget.exhibition.id)
                          .then((_) => setState(() {})),
                    ),
                  ],
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
