import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
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

  late TextEditingController _topLeftTextController;

  @override
  void initState() {
    super.initState();
    _homeBloc.onHomeInit();
    _topLeftTextController = TextEditingController(text: '[null]');
  }

  @override
  void dispose() {
    super.dispose();
    _homeBloc.close();
  }

  int _chatwheelItemCount(HomeState state) => state.hasReachedEndOfResults
      ? state.lines.length
      : state.lines.length + 1;

  bool _isAvailableNextPage(int index, HomeState state) =>
      index >= state.lines.length && !state.hasReachedEndOfResults;

  Widget _centerLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _playButton(HomeState state, ChatwheelLine cl) => IconButton(
        onPressed: () async {
          await _audioPlayer.play(cl.localPath, isLocal: true);
        },
        icon: Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
      );

  bool _isDownloading(HomeState state, ChatwheelLine cl) =>
      state.isDownloading && state.downloadingId == cl.id;

  bool _isDownloaded(HomeState state, ChatwheelLine cl) =>
      state.isDownloaded && state.downloadingId == cl.id;

  Widget _downloadButton(ChatwheelLine cl, int index) => IconButton(
        onPressed: () {
          _homeBloc.downloadChatwheel(
              downloadUrl: cl.url,
              fileName: cl.line,
              downloadingId: cl.id,
              downloadingIndex: index);
        },
        icon: Icon(
          Icons.download,
          color: Colors.orange,
        ),
      );

  Widget _listItem(ChatwheelLine cl, HomeState state, int index) => ListTile(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Set line on chatwheel'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {}, child: Text('set to chatwheel 1')),
                  TextButton(
                      onPressed: () {}, child: Text('set to chatwheel 2')),
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () {},
                    child: Text('set to chatwheel 3'),
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) => AlertDialog(
          //           content: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Text('Add line to chatwheel'),
          //                 SizedBox(height: 8.0),
          //                 Row(
          //                   children: [
          //                     // top left wheel
          //                     TextField(
          //                       controller: _topLeftTextController,
          //                       readOnly: true,
          //                     ),
          //                     Spacer(),
          //                     MaterialButton(
          //                       onPressed: () {
          //                         print('attaching');
          //                       },
          //                       child: Text('attach'),
          //                     )
          //                   ],
          //                 ),
          //                 SizedBox(height: 16.0),
          //                 MaterialButton(
          //                   onPressed: () {
          //                     Navigator.pop(context);
          //                   },
          //                   child: Text('confirm'),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ));
        },
        title: Text(cl.line),
        trailing: cl.localPath.isNotEmpty
            ? _playButton(state, cl)
            : _isDownloading(state, cl)
                ? CircularProgressIndicator()
                : _isDownloaded(state, cl)
                    ? _playButton(state, cl)
                    : _downloadButton(cl, index),
      );

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
              return _centerLoading();
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
                  itemCount: _chatwheelItemCount(state),
                  itemBuilder: (BuildContext context, int index) {
                    ChatwheelLine? chatwheel;
                    try {
                      chatwheel = state.lines[index];
                    } on RangeError catch (_) {
                      chatwheel = null;
                    }
                    return _isAvailableNextPage(index, state)
                        ? _centerLoading()
                        : _listItem(chatwheel!, state, index);
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
