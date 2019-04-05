import 'package:flutter/material.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expo/ui/exhibitions/exhibition_default_view.dart';
import 'package:expo/ui/theme/theme.dart';

class ExhibitionTile extends StatelessWidget {
  final ExhibitionEntity exhibition;

  ExhibitionTile({this.exhibition});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: exhibition.photos.first,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height / 3,
          ),
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_half,
                  color: Colors.yellow,
                ),
                Text('${exhibition.votes != null ? exhibition.votes : 4.7}'),
              ],
            ),
            title: Text(exhibition.name),
            subtitle: Text(exhibition.description ?? 'No description'),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: [
                Text('Made by ${exhibition.creators.values.first}', style: TextStyle(
                  color: Colors.black26
                ),),
                FlatButton(
                  child: Text(
                    'View',
                    style: TextStyle(color: ExpoColors.hvlAccent),
                  ),
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ExhibitionDefaultView(exhibition, votable: false,)),
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
}
