import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/data/models/media_content_model.dart';
import 'package:movie_app/core/presentation/app_router.dart';

class MediaContentSlider extends StatelessWidget {
  const MediaContentSlider({
    super.key,
    required this.list,
    required this.categoryTitle,
  });

  final List<MediaContentModel> list;
  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), child: Text(categoryTitle, style: GoogleFonts.poppins(fontSize: 18))),
        SizedBox(
          height: 250,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              final MediaContentModel mediaContent = list[index];
              return GestureDetector(
                onTap: () => context.router.push(MovieDetailsRoute(movieId: mediaContent.id)),
                child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(left: 13),
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: mediaContent.fullPosterPath ?? '',
                            placeholder: (BuildContext context, String url) =>
                                Padding(padding: const EdgeInsets.all(50), child: Center(child: CircularProgressIndicator())),
                            errorWidget: (BuildContext context, String url, Object error) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/placeholder/placeholder-image.png',
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 110,
                                ),
                              ),
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 3, left: 3),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                  child: Row(
                                    children: <Widget>[
                                      const Icon(Icons.star, color: Colors.amber, size: 15),
                                      SizedBox(width: 2),
                                      Text(
                                        mediaContent.voteAverage!.toStringAsFixed(1),
                                        style: GoogleFonts.poppins(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
