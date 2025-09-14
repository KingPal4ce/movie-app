import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/data/models/cast_member_model.dart';

class CastList extends StatelessWidget {
  const CastList({super.key, required this.castMember});

  final CastMemberModel castMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: castMember.fullProfilePath ?? '',
              height: 100,
              width: 80,
              fit: BoxFit.cover,
              placeholder: (BuildContext context, String url) => CircularProgressIndicator(),
              errorWidget: (BuildContext context, String url, Object error) =>
                  Container(decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary), child: Icon(Icons.person, size: 80)),
            ),
          ),
          const SizedBox(height: 5),
          Text(castMember.name!, style: TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
          Text('As: ${castMember.character}', style: TextStyle(fontSize: 10, color: Colors.grey), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
