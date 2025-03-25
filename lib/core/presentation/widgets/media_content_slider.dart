import 'package:flutter/material.dart';
import 'package:flutter_intro_bootcamp_project/core/data/models/media_content_model.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/presentation/screens/movie_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaContentSlider extends StatelessWidget {
  const MediaContentSlider({super.key, required this.list, required this.categoryTitle, required this.itemCount});

  final List<MediaContentModel> list;
  final String categoryTitle;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 10, top: 25, bottom: 35), child: Text(categoryTitle, style: GoogleFonts.poppins(fontSize: 18))),
        SizedBox(
          height: 250,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              final MediaContentModel mediaContent = list[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<Widget>(builder: (BuildContext context) => MovieDetailsScreen(movieId: mediaContent.id)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.3), BlendMode.darken),
                      image: NetworkImage('https://image.tmdb.org/t/p/w500${mediaContent.posterPath}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: EdgeInsets.only(left: 13),
                  width: 170,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2, right: 6),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.star, color: Colors.yellow, size: 15),
                                SizedBox(width: 2),
                                Text(mediaContent.voteAverage.toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
