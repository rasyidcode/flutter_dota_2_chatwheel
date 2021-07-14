import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dota_2_chatwheel/injection_container.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_bloc.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_state.dart';
import 'package:kiwi/kiwi.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = KiwiContainer().resolve<HomeBloc>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeBloc.onHomeInit();
  }

  @override
  void dispose() {
    super.dispose();
    _homeBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _homeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: BlocBuilder(
          bloc: _homeBloc,
          builder: (BuildContext context, HomeState state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.isSuccessful) {
              return NotificationListener(
                onNotification: (ScrollNotification scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      _scrollController.position.extentAfter == 0) {
                    _homeBloc.fetchNextPage();
                  }
                  return false;
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.hasReachedEndOfResults
                      ? state.lines.length
                      : state.lines.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.lines.length &&
                            !state.hasReachedEndOfResults
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListTile(
                            title: Text(state.lines[index].line),
                            trailing: IconButton(
                                onPressed: () async {
                                  await _audioPlayer
                                      .play(state.lines[index].url);
                                },
                                icon: Icon(Icons.audiotrack)),
                          );
                  },
                ),
              );
            } else {
              return Center(
                child: Text(state.error),
              );
            }
          },
        ),
      ),
    );
  }
}
