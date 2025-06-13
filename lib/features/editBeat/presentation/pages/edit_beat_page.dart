import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/app/app_router.dart';
import 'package:vibeat_web/app/injection_container.dart';
import 'package:vibeat_web/custom_functions.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_data/basic_data_beat.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_files/drag_drop_mp3.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_files/drag_drop_wav.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_files/drag_drop_zip.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_files/edit_cover.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_tags/edit_tags.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_data/info_beat_widget.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/license_cart_widget.dart';

@RoutePage()
class EditBeatPage extends StatefulWidget {
  const EditBeatPage({super.key, required this.beat, required this.isEditMode});

  final BeatEntity beat;
  final bool isEditMode;

  @override
  State<EditBeatPage> createState() => _EditBeatPageState();
}

class _EditBeatPageState extends State<EditBeatPage> {
  Dio dio = Dio();

  bool isUploading = false;
  bool fileAdded = false;

  String nameFile1 = "";
  double progress = 0;
  final bool _switchValue = false;

  // Future<void> deleteFile() async {
  //   final response = await dio.post(
  //     "http://192.168.0.135:7774/api/presigned/getPresignedDeleteRequest",
  //     data: {
  //       "BucketName": "beatsfordiplomaexample",
  //       "ObjectKey": nameFile1,
  //     },
  //     options: Options(headers: {
  //       'Content-Type': 'application/json',
  //     }),
  //   );

  //   final url = response.data['data']['URL'];

  //   final response2 = await dio.delete(
  //     'https://cors-anywhere.herokuapp.com/' + url,
  //     options: Options(headers: {
  //       'Content-Type': 'application/json',
  //     }),
  //   );

  //   if (response2.statusCode == 204) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('$nameFile1 deleted successfully')),
  //     );

  //     setState(() {
  //       fileAdded = false;
  //       nameFile1 = '';
  //       isUploading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditBeatBloc>(
      create: (context) {
        final bloc = sl<EditBeatBloc>(
          param1: widget.beat,
          param2: widget.isEditMode,
        );

        bloc.add(const GetDataTemplateLicense());

        return bloc;
      },
      child: BlocListener<EditBeatBloc, BeatState>(
        listener: (context, state) {
          if (state is BeatEditState && state.isSavedSuccess == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              setupSnackBar("Beat saved"),
            );
          }

          if (state is BeatEditState && state.isBeatPublish == true) {
            context.read<EditBeatBloc>().add(const PublishBeatSuccess());

            ScaffoldMessenger.of(context).showSnackBar(
              setupSnackBar("Beat on moderation"),
            );

            context.router.push(const AllBeatsRoute());
          }
        },
        child: Builder(
          builder: (context) => Scaffold(
            backgroundColor: const Color(0xff0C0C0C),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Студия / Редактирование бита",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Helvetica",
                            ),
                          ),
                          Text(
                            "Редактирование бита",
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Helvetica",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              MaterialButton(
                                height: 44,
                                onPressed: () {
                                  // context.router.popForced();

                                  context
                                      .read<EditBeatBloc>()
                                      .add(const SaveDraft());
                                },
                                color: const Color(0xff1E1E1E),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Сохранить",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              MaterialButton(
                                height: 44,
                                onPressed: () {
                                  context.read<EditBeatBloc>().add(
                                        PublishBeatEvent(
                                          beatId: widget.beat.id,
                                        ),
                                      );
                                },
                                color: const Color(0xff8D40FF),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Опубликовать",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: true,
                    child: Container(
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
                            "Загрузите файлы",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "OpenSans",
                            ),
                          ),
                          const SizedBox(height: 52),
                          DragAndDropMp3(beatId: widget.beat.id),
                          Padding(
                            padding: const EdgeInsets.only(top: 22),
                            child: Row(
                              children: [
                                Flexible(
                                    child:
                                        DragAndDropWav(beatId: widget.beat.id)),
                                const SizedBox(
                                  width: 22,
                                ),
                                Flexible(
                                    child:
                                        DragAndDropZip(beatId: widget.beat.id)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const BasicDataBeat(),
                  const EditTags(),
                  const GenreSelector(),
                  CoverBeat(beatId: widget.beat.id),
                  Visibility(
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Добавить лицензии",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "OpenSans",
                            ),
                          ),
                          SizedBox(height: 52),
                          LicenseWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
