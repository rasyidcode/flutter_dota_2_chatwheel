import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_bloc.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_state.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/widgets/positioned_dot_button.dart';
import 'package:kiwi/kiwi.dart';

enum DotPosition {
  NONE,
  TOP_LEFT,
  TOP_CENTER,
  TOP_RIGHT,
  RIGHT_CENTER,
  BOTTOM_RIGHT,
  BOTTOM_CENTER,
  BOTTOM_LEFT,
  LEFT_CENTER,
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = KiwiContainer().resolve<HomeBloc>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();

  DotPosition _currentActiveDot = DotPosition.NONE;

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

  int _chatwheelItemCount(HomeState state) => state.hasReachedEndOfResults
      ? state.lines.length
      : state.lines.length + 1;

  bool _isAvailableNextPage(int index, HomeState state) =>
      index >= state.lines.length && !state.hasReachedEndOfResults;

  void changeActiveDot(StateSetter state, DotPosition dotPosition) {
    state(() {
      _currentActiveDot = dotPosition;
    });
  }

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
          showDialog(context: context, builder: (_) => _buildDialog());
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

  List<Widget> _buildPositionedDotButtonList(StateSetter state) => [
        PositionedDotButton(
          onTap: () => changeActiveDot(state, DotPosition.TOP_LEFT),
          top: 0,
          left: 50,
          color: _currentActiveDot == DotPosition.TOP_LEFT
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, DotPosition.TOP_CENTER),
          top: 0,
          right: 100.0 - 5.0,
          color: _currentActiveDot == DotPosition.TOP_CENTER
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, DotPosition.TOP_RIGHT),
          top: 0,
          right: 50,
          color: _currentActiveDot == DotPosition.TOP_RIGHT
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, DotPosition.BOTTOM_RIGHT),
          bottom: 0,
          right: 50.0,
          color: _currentActiveDot == DotPosition.BOTTOM_RIGHT
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, DotPosition.BOTTOM_LEFT),
          bottom: 0,
          left: 50.0,
          color: _currentActiveDot == DotPosition.BOTTOM_LEFT
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, DotPosition.BOTTOM_CENTER),
          bottom: 0,
          left: 100.0 - 5.0,
          color: _currentActiveDot == DotPosition.BOTTOM_CENTER
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, DotPosition.RIGHT_CENTER),
          bottom: 45 - 8,
          right: 50,
          color: _currentActiveDot == DotPosition.RIGHT_CENTER
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, DotPosition.LEFT_CENTER),
          bottom: 45 - 8,
          left: 50,
          color: _currentActiveDot == DotPosition.LEFT_CENTER
              ? Colors.red
              : Colors.white54,
        )
      ];

  Widget _buildDialog() {
    return StatefulBuilder(builder: (_, StateSetter dialogState) {
      return AlertDialog(
        title: Text(
          'Set line on chatwheel',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100.0,
                child: Stack(
                  children: _buildPositionedDotButtonList(dialogState),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Please select where you want to place it',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            onPressed: () {
              print('confirmed');
            },
            child: Text(
              'Confirm',
              style: TextStyle(
                fontWeight: FontWeight.w100,
              ),
            ),
            color: Theme.of(context).primaryColor,
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
            ),
            child: Text(
              'Close',
              style: TextStyle(
                fontWeight: FontWeight.w100,
              ),
            ),
            onPressed: () {
              changeActiveDot(dialogState, DotPosition.NONE);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
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
