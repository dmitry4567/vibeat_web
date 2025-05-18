import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';

class DragAndDropWav extends StatefulWidget {
  const DragAndDropWav({super.key, required this.beatId});

  final String beatId;

  @override
  State<DragAndDropWav> createState() => _DragAndDropWavState();
}

class _DragAndDropWavState extends State<DragAndDropWav> {
  late final DropzoneViewController controller1;
  bool highlighted1 = false;
  String message1 = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBeatBloc, BeatState>(
      buildWhen: (previous, current) {
        if (previous is BeatEditState && current is BeatEditState) {
          return previous.beat != current.beat ||
              previous.isWavLoading != current.isWavLoading ||
              previous.progressWav != current.progressWav;
        }
        return false;
      },
      builder: (context, state) {
        if (state is BeatEditState) {
          return Stack(
            children: [
              Container(
                height: 122,
                decoration: BoxDecoration(
                  color: highlighted1
                      ? Colors.white.withOpacity(0.2)
                      : const Color(0xff262626),
                  borderRadius: BorderRadius.circular(8),
                  border: DashedBorder.fromBorderSide(
                    dashLength: 10,
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    Listener(
                      onPointerDown: (_) async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          final file = result.files.first;

                          log(file.name.toString());

                          context.read<EditBeatBloc>().add(
                                AddWavFile(
                                  beatId: widget.beatId,
                                  file: file,
                                ),
                              );
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      child: DropzoneView(
                        mime: const ["audio/wav"],
                        operation: DragOperation.move,
                        // cursor: CursorType.grab,
                        onCreated: (ctrl) => controller1 = ctrl,
                        onLoaded: () => print('Zone 1 loaded'),
                        onError: (error) => print('Zone 1 error: $error'),
                        onHover: () {
                          setState(() => highlighted1 = true);
                          print('Zone 1 hovered');
                        },
                        onLeave: () {
                          setState(() => highlighted1 = false);
                          print('Zone 1 left');
                        },
                        onDropFile: (file) async {
                          print('Zone 1 drop: ${file.name}');
                          setState(() {
                            message1 = '${file.name} dropped';
                            highlighted1 = false;
                          });

                          final bytes = await controller1.getFileData(file);

                          // await uploadFileToS3(bytes, file.name);
                        },
                        onDropString: (s) {
                          print('Zone 1 drop: $s');
                          setState(() {
                            message1 = 'text dropped';
                            highlighted1 = false;
                          });
                        },
                        onDropInvalid: (mime) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Failed type")),
                          );
                        },
                      ),
                    ),
                    if (state.isWavLoading == IsWavLoading.loading)
                      Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          value: state.progressWav,
                          strokeWidth: 3,
                        ),
                      ),
                    if (state.isWavLoading == IsWavLoading.success ||
                        state.beat.availableFiles.wavUrl != "")
                      const Center(
                        child: Text(
                          "Файл загружен",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (state.beat.availableFiles.wavUrl == "" &&
                  state.isWavLoading != IsWavLoading.loading)
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Перетащите сюда WAV файл",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Helvetica",
                      ),
                    ),
                  ),
                ),
              if (state.beat.availableFiles.wavUrl != "")
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      // deleteFile();
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.white,
                  ),
                ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
