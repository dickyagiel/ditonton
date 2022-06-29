import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/domain/entities/genre.dart';
import 'package:ditonton/features/tvs/domain/entities/tv.dart';
import 'package:ditonton/features/tvs/domain/entities/tv_detail.dart';
import 'package:ditonton/features/tvs/presentation/blocs/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/tv_recommendations/recommendations_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/watchlist_event/watchlist_event_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/watchlist_status/watchlist_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TVDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TVDetailPage({required this.id});

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistStatusBloc>().add(WatchlistStatus(widget.id));
    context.read<TvDetailBloc>().add(TvDetail(widget.id));
    context.read<RecommendationsTvBloc>().add(RecommendationsTv(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailStateLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailStateLoaded) {
            final tv = state.result;
            return SafeArea(
              child: DetailContent(tv: tv),
            );
          } else if (state is TvDetailStateError) {
            return Text(state.message);
          } else {
            return Text("Empty");
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVDetail tv;

  DetailContent({required this.tv});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            BlocListener<WatchlistEventBloc,
                                WatchlistEventState>(
                              listener: (context, state) {
                                if (state is WatchlistEventStateLoaded) {
                                  final message = state.message;
                                  if (message == 'Added to Watchlist' ||
                                      message == 'Removed from Watchlist') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(message)));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        });
                                  }
                                }
                              },
                              child: BlocBuilder<WatchlistStatusBloc,
                                  WatchlistStatusState>(
                                builder: (context, state) {
                                  if (state is WatchlistStatusTrue) {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        context
                                            .read<WatchlistEventBloc>()
                                            .add(RemoveWatchList(tv));
                                        context
                                            .read<WatchlistStatusBloc>()
                                            .add(WatchlistStatus(tv.id));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.check),
                                          Text('Watchlist'),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        context
                                            .read<WatchlistEventBloc>()
                                            .add(AddtoWatchList(tv));
                                        context
                                            .read<WatchlistStatusBloc>()
                                            .add(WatchlistStatus(tv.id));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.add),
                                          Text('Watchlist'),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(
                              _showDuration(tv.episodeRuntime[0]),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationsTvBloc,
                                RecommendationsTvState>(
                              builder: (context, state) {
                                if (state is RecommendationsTvStateLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationsTvStateError) {
                                  return Text(state.message);
                                } else if (state
                                    is RecommendationsTvStateLoaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie =
                                            state.recomendation[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.recomendation.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
