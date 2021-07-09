import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_event.dart';
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
  int _selectedEvent = 0;

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
              return ListView.builder(
                itemCount: state.events.length,
                itemBuilder: (BuildContext context, int index) {
                  if (state.events[index] != null) {
                    final ChatwheelEvent eventData = state.events[index]!;
                    return ExpansionTile(
                      key: UniqueKey(),
                      initiallyExpanded: _selectedEvent == index,
                      title: Text(
                        eventData.eventName,
                      ),
                      children: eventData.packs
                          .map(
                            (pack) => ExpansionTile(
                              key: UniqueKey(),
                              title: Text(pack.packName.isNotEmpty
                                  ? pack.packName
                                  : '[undefined]'),
                              children: [
                                Text(
                                  'Battle Pass Level : ${pack.bpLevel}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(fontSize: 16),
                                ),
                                Column(
                                  children: pack.lines
                                      .map(
                                        (line) => ListTile(
                                          key: UniqueKey(),
                                          title: Text(line.line),
                                          trailing: IconButton(
                                            onPressed: () async {
                                              int result = await _audioPlayer
                                                  .play(line.url);
                                              if (result != 1) {
                                                print(
                                                    'failed to play the song');
                                              }
                                            },
                                            icon: Icon(Icons.audiotrack),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              ],
                            ),
                          )
                          .toList(),
                      onExpansionChanged: (isOpen) {
                        setState(() {
                          _selectedEvent = index;
                        });
                      },
                    );
                  } else {
                    return Container();
                  }
                },
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
