import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/app/injection_container.dart';
import 'package:vibeat_web/custom_functions.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_data/basic_data.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_files/drag_drop_mp3.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_files/drag_drop_wav.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_files/drag_drop_zip.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_files/edit_cover.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_tags/edit_tags.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/edit_data/info_beat_widget.dart';
import 'package:uuid/uuid.dart';

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

  Future<void> deleteFile() async {
    final response = await dio.post(
      "http://192.168.0.135:7774/api/presigned/getPresignedDeleteRequest",
      data: {
        "BucketName": "beatsfordiplomaexample",
        "ObjectKey": nameFile1,
      },
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
    );

    final url = response.data['data']['URL'];

    final response2 = await dio.delete(
      'https://cors-anywhere.herokuapp.com/' + url,
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
    );

    if (response2.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$nameFile1 deleted successfully')),
      );

      setState(() {
        fileAdded = false;
        nameFile1 = '';
        isUploading = false;
      });
    }
  }

  Future<void> uploadFileToS3(Uint8List fileBytes, String fileName) async {
    setState(() => isUploading = true);

    try {
      var uuid = const Uuid();
      String v4 = uuid.v1();

      // Получаем presigned URL
      final response = await dio.post(
        "http://192.168.0.135:7774/api/presigned/PresignedPostRequest/mp3beats",
        data: {
          "uuidFileName": v4,
          "file": fileName,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      final url = response.data['data']['URL'];

      // Загружаем файл на S3
      final uploadResponse = await dio.put(
        url,
        // 'https://cors-anywhere.herokuapp.com/' + url,
        data: fileBytes,
        options: Options(
          headers: {
            // 'Content-Type': 'multipart/form-data',
            'Content-Type': 'audio/mpeg',
            'Access-Control-Allow-Origin': '*',
          },
        ),
        onSendProgress: (int sent, int total) {
          setState(() {
            progress = sent / total;
            print('Upload progress: ${progress * 100}%');
          });
        },
      );

      if (uploadResponse.statusCode == 200) {
        print('File uploaded successfully to Yandex Cloud S3');

        final response = await dio.post(
          "http://192.168.0.135:7774/api/updateURL/beat/mp3",
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
          data: {
            "id": "01966d6f-10d4-79cf-876b-50242cc9b8a5",
            "objectKey": v4,
          },
        );

        if (response.statusCode == 200) {
          log("file is added");

          setState(() {
            nameFile1 = fileName;
            fileAdded = true;
            progress = 0;
          });
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$fileName uploaded successfully')),
          );
        }
      } else {
        throw Exception('Failed to upload file: ${uploadResponse.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
        print('Response status: ${e.response?.statusCode}');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload $fileName: ${e.message}')),
        );
      }
    } catch (e) {
      print('Error uploading file to Yandex Cloud S3: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload $fileName: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditBeatBloc>(
      create: (context) => sl<EditBeatBloc>(
        param1: widget.beat,
        param2: widget.isEditMode,
      ),
      child: BlocListener<EditBeatBloc, BeatState>(
        listener: (context, state) {
          if (state is BeatEditState && state.isSavedSuccess == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              setupSnackBar("Beat saved"),
            );
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Студия / Редактирование бита    ${widget.beat.id}   editMode: ${widget.isEditMode.toString()}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Helvetica",
                            ),
                          ),
                          const Text(
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

                                  context.read<EditBeatBloc>().add(const SaveDraft());
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
                                onPressed: () {},
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
                  const BasicData(),
                  const EditTags(),
                  const GenreSelector(),
                  CoverBeat(beatId: widget.beat.id),
                  // Visibility(
                  //   visible: true,
                  //   child: Container(
                  //     margin: const EdgeInsets.only(top: 8),
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 33,
                  //       vertical: 28,
                  //     ),
                  //     decoration: const BoxDecoration(
                  //       color: Color(0xff151515),
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(12),
                  //       ),
                  //     ),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Text(
                  //           "Добавить лицензии",
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w400,
                  //             fontFamily: "OpenSans",
                  //           ),
                  //         ),
                  //         const SizedBox(height: 52),
                  //         Wrap(
                  //           spacing: 36.0,
                  //           runSpacing: 20.0,
                  //           children: List.generate(4, (index) {
                  //             return ConstrainedBox(
                  //               constraints: BoxConstraints(
                  //                   maxWidth: (MediaQuery.of(context).size.width -
                  //                           200 -
                  //                           178) /
                  //                       2),
                  //               child: const LicenseWidget(),
                  //             );
                  //           }),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
