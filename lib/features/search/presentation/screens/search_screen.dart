import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/presentation/app_router.dart';
import 'package:movie_app/core/presentation/widgets/my_loading_indicator.dart';
import 'package:movie_app/features/search/data/models/media_content_search_model.dart';
import 'package:movie_app/features/search/domain/blocs/search_bloc.dart';
import 'package:movie_app/features/search/domain/blocs/search_states.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchText = TextEditingController();
  bool showList = false;

  late SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    searchBloc = context.read<SearchBloc>();
    searchBloc.fetchSearchResults(searchText.text);
  }

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          showList = !showList;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              TextField(
                controller: searchText,
                onSubmitted: (String value) {
                  if (value.isNotEmpty) {
                    searchBloc.fetchSearchResults(value);
                    setState(() {
                      showList = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              showList
                  ? BlocBuilder<SearchBloc, SearchStates>(
                      builder: (BuildContext context, SearchStates state) {
                        return state.maybeWhen(
                          loading: () => const MyLoadingIndicator(),
                          success: (List<MediaContentSearchModel> searchData) => Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: searchData.length,
                              itemBuilder: (BuildContext context, int index) {
                                final MediaContentSearchModel item = searchData[index];
                                return GestureDetector(
                                  onTap: () => context.router.push(MovieDetailsRoute(movieId: item.id)),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    height: 220,
                                    width: MediaQuery.of(context).size.width,
                                    decoration:
                                        BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: double.infinity,
                                          width: MediaQuery.of(context).size.width * 0.4,
                                          decoration:
                                              BoxDecoration(color: Theme.of(context).colorScheme.tertiary, borderRadius: BorderRadius.circular(10)),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: item.fullPosterPath ?? '',
                                              placeholder: (BuildContext context, String url) =>
                                                  Padding(padding: const EdgeInsets.all(50), child: CircularProgressIndicator()),
                                              errorWidget: (BuildContext context, String url, Object error) => Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                                child: Image.asset('assets/images/placeholder/placeholder-image.png',
                                                    color: Theme.of(context).colorScheme.inversePrimary),
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
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
                                                          Text(item.voteAverage.toStringAsFixed(1)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
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
                                                          const Icon(Icons.people_outline_sharp, color: Colors.amber, size: 20),
                                                          const SizedBox(width: 5),
                                                          Text(item.popularity!.toStringAsFixed(1)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                height: 85,
                                                child: Text(
                                                  (item.overview != '' && item.overview != null) ? item.overview! : 'No overview available...',
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                ),
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
                          error: (String message) => Center(child: Text("Error: $message")),
                          orElse: () => const Center(child: Text('Something went Wrong')),
                        );
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
