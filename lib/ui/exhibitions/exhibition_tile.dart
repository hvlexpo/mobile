import 'package:flutter/material.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expo/ui/exhibitions/exhibition_default_view.dart';
import 'package:expo/data/repositories/user_repository.dart';
import 'package:expo/utils/localization.dart';
import 'package:expo/ui/theme/theme.dart';

class ExhibitionTile extends StatelessWidget {
  final ExhibitionEntity exhibition;
  final userRepository = UserRepository();
  final String userId;

  ExhibitionTile({@required this.exhibition, this.userId = ''});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Hero(
            tag: '${exhibition.id}__hero',
            child: CachedNetworkImage(
              imageUrl: exhibition.photos.first,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          ListTile(
            leading: Hero(
              tag: '${exhibition.id}__id',
              child: Text(exhibition.id),
            ),
            title: Hero(
              tag: '${exhibition.id}__name',
              child: Text(exhibition.name),
            ),
            subtitle: Hero(
              tag: '${exhibition.id}__description',
              child: Text(exhibition.description ?? AppLocalizations.of(context).noDescription),
            ),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildUserVotes(),
                FlatButton(
                  child: Text(
                    AppLocalizations.of(context).view,
                    style: TextStyle(color: ExpoColors.hvlAccent),
                  ),
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ExhibitionDefaultView(
                                  exhibition,
                                  votable: false,
                                )),
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  double _getAverageVotes(Map<String, int> votes) {
    int totalCount;
    int totalWeight;

    votes.forEach((key, val) {
      totalCount += int.parse(key);
      totalWeight += val;
    });

    return (totalWeight / totalCount);
  }

  Widget _buildUserVotes() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: userRepository.fetchUserVotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int weight;
          final vote = snapshot.data.firstWhere(
              (i) => i['exhibition_id'] == exhibition.id,
              orElse: () => {'weight': '0'});
          weight = int.parse(vote['weight']);
          return weight != 0
              ? Column(
                  children: [
                    Text(
                      AppLocalizations.of(context).yourVote,
                      style: TextStyle(color: Colors.black26),
                    ),
                    Row(
                        children: [1, 2, 3, 4, 5].map((index) {
                      return Icon(
                        Icons.star,
                        color:
                            (index <= weight) ? Colors.yellow : Colors.black12,
                        size: (index <= weight) ? 16 : 14,
                      );
                    }).toList()),
                  ],
                )
              : Container();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
