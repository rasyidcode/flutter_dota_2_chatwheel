import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/enums/wheel_position.dart';
import 'package:flutter_dota_2_chatwheel/ui/chat_wheel/chat_wheel_bloc.dart';
import 'package:flutter_dota_2_chatwheel/ui/chat_wheel/chat_wheel_state.dart';
import 'package:flutter_dota_2_chatwheel/ui/chat_wheel/widgets/positioned_dot_button.dart';
import 'package:flutter_dota_2_chatwheel/extensions/string_extensions.dart';
import 'package:kiwi/kiwi.dart';

class ChatWheelPage extends StatefulWidget {
  ChatWheelPage({Key? key}) : super(key: key);

  @override
  _ChatWheelPageState createState() => _ChatWheelPageState();
}

class _ChatWheelPageState extends State<ChatWheelPage> {
  final ChatWheelBloc _homeBloc = KiwiContainer().resolve<ChatWheelBloc>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();

  WheelPosition _currentActiveDot = WheelPosition.none;

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

  int _chatwheelItemCount(ChatWheelState state) => state.hasReachedEndOfResults
      ? state.lines.length
      : state.lines.length + 1;

  bool _isAvailableNextPage(int index, ChatWheelState state) =>
      index >= state.lines.length && !state.hasReachedEndOfResults;

  void changeActiveDot(StateSetter state, WheelPosition dotPosition) {
    state(() {
      _currentActiveDot = dotPosition;
    });
  }

  // case -> localPath not empty in the line, but file doesn't exist
  // if this case happend we need to warn the user to download it again
  Future<bool> isFileExist(int id, String localPath) async {
    bool fileExist = await localPath.isFileExist();
    if (!fileExist) {
      _homeBloc.updateLocalPath(id, '');
      return false;
    }

    return true;
  }

  Widget _centerLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _playButton(ChatWheelState state, ChatwheelLine cl) => IconButton(
        onPressed: () async {
          await _audioPlayer.play(cl.localPath, isLocal: true);
        },
        icon: Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
      );

  bool _isDownloading(ChatWheelState state, ChatwheelLine cl) =>
      state.isDownloading != null &&
      state.isDownloading! &&
      state.downloadingId == cl.id;

  bool _isDownloaded(ChatWheelState state, ChatwheelLine cl) =>
      state.isDownloaded != null &&
      state.isDownloaded! &&
      state.downloadingId == cl.id;

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

  Widget _listItem(ChatwheelLine cl, ChatWheelState state, int index) =>
      ListTile(
          onTap: () {
            // TODO: check file is exist or not, if file exist show dialog else show warning dialog
            showDialog(
                context: context, builder: (_) => _buildDialog(cl.id, state));
          },
          title: Text(
            cl.line,
            style: TextStyle(
              fontWeight: FontWeight.w100,
            ),
          ),
          trailing: cl.localPath.isNotEmpty
              ? FutureBuilder(
                  future: isFileExist(cl.id!, cl.localPath),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasError) {
                      return Icon(Icons.close, color: Colors.red);
                    }

                    bool? isFileExist = snapshot.data;
                    if (isFileExist != null) {
                      return snapshot.hasData
                          ? cl.localPath.isNotEmpty
                              ? _playButton(state, cl)
                              : _isDownloading(state, cl)
                                  ? CircularProgressIndicator()
                                  : _isDownloaded(state, cl)
                                      ? _playButton(state, cl)
                                      : _downloadButton(cl, index)
                          : CircularProgressIndicator();
                    } else {
                      return Icon(Icons.close, color: Colors.red);
                    }
                  },
                )
              : cl.localPath.isNotEmpty
                  ? _playButton(state, cl)
                  : _isDownloading(state, cl)
                      ? CircularProgressIndicator()
                      : _isDownloaded(state, cl)
                          ? _playButton(state, cl)
                          : _downloadButton(cl, index));

  List<Widget> _buildPositionedDotButtonList(StateSetter state) => [
        PositionedDotButton(
          onTap: () => changeActiveDot(state, WheelPosition.topLeft),
          top: 0,
          left: 50,
          color: _currentActiveDot == WheelPosition.topLeft
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, WheelPosition.topCenter),
          top: 0,
          right: 100.0 - 5.0,
          color: _currentActiveDot == WheelPosition.topCenter
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, WheelPosition.topRight),
          top: 0,
          right: 50,
          color: _currentActiveDot == WheelPosition.topRight
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, WheelPosition.bottomRight),
          bottom: 0,
          right: 50.0,
          color: _currentActiveDot == WheelPosition.bottomRight
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, WheelPosition.bottomLeft),
          bottom: 0,
          left: 50.0,
          color: _currentActiveDot == WheelPosition.bottomLeft
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, WheelPosition.bottomCenter),
          bottom: 0,
          left: 100.0 - 5.0,
          color: _currentActiveDot == WheelPosition.bottomCenter
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, WheelPosition.rightCenter),
          bottom: 45 - 8,
          right: 50,
          color: _currentActiveDot == WheelPosition.rightCenter
              ? Colors.red
              : Colors.white54,
        ),
        PositionedDotButton(
          onTap: () => changeActiveDot(state, WheelPosition.leftCenter),
          bottom: 45 - 8,
          left: 50,
          color: _currentActiveDot == WheelPosition.leftCenter
              ? Colors.red
              : Colors.white54,
        )
      ];

  Widget _buildDialog(int? lineId, ChatWheelState state) {
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
              Navigator.of(context).pop();
              if (lineId != null) {
                _homeBloc.updateDotChatwheel(
                    id: lineId,
                    showInWheel: true,
                    wheelPosition: _currentActiveDot);

                if (state.showInLineErrorMessage != null &&
                    state.showInLineErrorMessage != '')
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            state.showInLineErrorMessage!,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              }
              setState(() {
                _currentActiveDot = WheelPosition.none;
              });
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
              changeActiveDot(dialogState, WheelPosition.none);
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
          centerTitle: true,
          title: Text(
            'Chat Wheel',
            style: TextStyle(
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
        body: BlocBuilder(
          bloc: _homeBloc,
          builder: (BuildContext context, ChatWheelState state) {
            if (state.isLoading) {
              return _centerLoading();
            }

            if (state.isSuccessful) {
              return Stack(children: [
                NotificationListener(
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
                ),
                state.isUpdatingShowInLine != null &&
                        state.isUpdatingShowInLine!
                    ? Container(
                        color: Colors.black.withOpacity(0.4),
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(),
              ]);
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
