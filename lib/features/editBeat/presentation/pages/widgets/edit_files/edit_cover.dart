import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';

class CoverBeat extends StatefulWidget {
  const CoverBeat({super.key, required this.beatId});

  final String beatId;

  @override
  State<CoverBeat> createState() => _CoverBeatState();
}

class _CoverBeatState extends State<CoverBeat> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBeatBloc, BeatState>(
      buildWhen: (previous, current) {
        if (previous is BeatEditState && current is BeatEditState) {
          return previous.beat != current.beat ||
              previous.isCoverLoading != current.isCoverLoading ||
              previous.progressCover != current.progressCover;
        }
        return false;
      },
      builder: (context, state) {
        if (state is BeatEditState) {
          return Visibility(
            visible: true,
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 33,
                vertical: 28,
              ),
              decoration: const BoxDecoration(
                color: Color(0xff151515),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Обложка",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: "OpenSans",
                    ),
                  ),
                  const SizedBox(height: 52),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Color(0xff363636),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Stack(
                          children: [
                            if (state.isCoverLoading ==
                                    IsCoverLoading.success ||
                                state.isCoverLoading == IsCoverLoading.initial)
                              Positioned(
                                width: 200,
                                height: 200,
                                child: Image.network(
                                  state.beat.urlPicture != ""
                                      ? "http://storage.yandexcloud.net/imagesall/${state.beat.urlPicture}"
                                      : "",
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Text(state.beat.urlPicture);
                                  },
                                ),
                              ),
                            if (state.isCoverLoading == IsCoverLoading.loading)
                              Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  value: state.progressCover,
                                  strokeWidth: 3,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialButton(
                              height: 44,
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  final file = result.files.first;

                                  log(file.name.toString());

                                  context.read<EditBeatBloc>().add(
                                        AddCoverFileEvent(
                                          beatId: widget.beatId,
                                          file: file,
                                        ),
                                      );
                                }
                              },
                              color: const Color(0xff262626),
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 20,
                                top: 14,
                                bottom: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      state.beat.urlPicture == ""
                                          ? const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 18,
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    state.beat.urlPicture == ""
                                        ? "Добавить обложку"
                                        : "Изменить обложку",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: "OpenSans",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Формат .JPG\nСоотношение сторон 1:1",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  height: 2,
                                  fontFamily: "Helvetica"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
