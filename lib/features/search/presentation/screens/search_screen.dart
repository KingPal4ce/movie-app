import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/presentation/screens/movie_details_screen.dart';
import 'package:flutter_intro_bootcamp_project/features/search/data/models/media_content_search_model.dart';
import 'package:flutter_intro_bootcamp_project/features/search/domain/blocs/search_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/search/domain/blocs/search_states.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchText = TextEditingController();
  bool showList = false;

  @override
  void initState() {
    super.initState();
    final SearchBloc searchBloc = context.read<SearchBloc>();
    searchBloc.fetchSearchResults(searchText.text);
  }

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        showList = !showList;
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 30, bottom: 20, right: 10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: searchText,
              onSubmitted: (String value) {
                if (value.isNotEmpty) {
                  context.read<SearchBloc>().fetchSearchResults(value);
                  setState(() {
                    showList = true;
                  });
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 5),
            showList
                ? BlocBuilder<SearchBloc, SearchStates>(
                  builder: (BuildContext context, SearchStates state) {
                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator(color: Colors.amber));
                    } else if (state is SearchError) {
                      return Text(state.message);
                    } else if (state is SearchLoaded) {
                      return _buildResultsList(state.searchData ?? <MediaContentSearchModel>[]);
                    }
                    return Container();
                  },
                )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(List<MediaContentSearchModel> results) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: results.length,
          itemBuilder: (BuildContext context, int index) {
            final MediaContentSearchModel item = results[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => MovieDetailsScreen(movieId: item.id)));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                height: 220,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: const Color.fromRGBO(20, 20, 20, 1), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: NetworkImage(item.fullPosterPath ?? ''), fit: BoxFit.fill),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.amber.withValues(alpha: 0.2),
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Icon(Icons.star, color: Colors.amber, size: 20),
                                      const SizedBox(width: 5),
                                      Text(item.voteAverage.toString()),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 30,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(color: Colors.amber.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(Icons.people_outline_sharp, color: Colors.amber, size: 10),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          item.popularity?.toString() ?? 'N/A',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 85,
                            child: Text(item.overview ?? 'No overview available', overflow: TextOverflow.ellipsis, maxLines: 4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
