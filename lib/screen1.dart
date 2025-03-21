import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:vibeat_web/widgets/info_beat_widget.dart';
import 'package:vibeat_web/widgets/license_cart_widget.dart';
import 'package:vibeat_web/widgets/tag_widget.dart';

@RoutePage()
class Screenn1Page extends StatefulWidget {
  const Screenn1Page({super.key});

  @override
  State<Screenn1Page> createState() => _Screenn1PageState();
}

class _Screenn1PageState extends State<Screenn1Page> {
  Dio dio = Dio();

  late DropzoneViewController controller1;
  String message1 = 'Drop something here';
  bool highlighted1 = false;
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
      // Получаем presigned URL
      final response = await dio.post(
        "http://192.168.0.135:7774/api/presigned/getPresignedPostRequest",
        data: {
          "BucketName": "beatsfordiplomaexample",
          "ObjectKey": fileName,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      final url = response.data['data']['URL'];

      // Загружаем файл на S3
      final uploadResponse = await dio.put(
        'https://cors-anywhere.herokuapp.com/' + url,
        data: fileBytes,
        options: Options(
          headers: {
            'Content-Type':
                'multipart/form-data', // Указываем правильный Content-Type
            'Access-Control-Allow-Origin': '*',
          },
        ),
        onSendProgress: (int sent, int total) {
          setState(() {
            progress = sent / total;
            print('Upload progress: $progress%');
          });
        },
      );

      if (uploadResponse.statusCode == 200) {
        print('File uploaded successfully to Yandex Cloud S3');

        final response = await dio.get(
          "http://192.168.0.135:7774/api/presigned/updateBeatFileUri",
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
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
    return Scaffold(
      backgroundColor: const Color(0xff0C0C0C),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const Text(
              "Студия / Редактирование бита",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "Helvetica",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Редактирование бита",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Helvetica",
                  ),
                ),
                Row(
                  children: [
                    MaterialButton(
                      height: 44,
                      onPressed: () {},
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
                    Stack(
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

                                    uploadFileToS3(file.bytes!, file.name);
                                  }
                                },
                                behavior: HitTestBehavior.opaque,
                                child: DropzoneView(
                                  mime: const ["audio/mpeg"],
                                  operation: DragOperation.move,
                                  // cursor: CursorType.grab,
                                  onCreated: (ctrl) => controller1 = ctrl,
                                  onLoaded: () => print('Zone 1 loaded'),
                                  onError: (error) =>
                                      print('Zone 1 error: $error'),
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

                                    final bytes =
                                        await controller1.getFileData(file);

                                    await uploadFileToS3(bytes, file.name);
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
                                      const SnackBar(
                                          content: Text("Failed type")),
                                    );
                                  },
                                ),
                              ),
                              if (isUploading)
                                Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    value: progress,
                                  ),
                                ),
                              if (fileAdded)
                                Center(
                                  child: Text(
                                    "Файл загружен: $nameFile1",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (!isUploading && !fileAdded)
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Перетащите сюда MP3 файл",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Helvetica",
                                ),
                              ),
                            ),
                          ),
                        if (fileAdded)
                          Positioned(
                            top: 5,
                            right: 5,
                            child: IconButton(
                              onPressed: () {
                                deleteFile();
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 122,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                          Flexible(
                            child: Container(
                              height: 122,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Основные данные",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 545,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Название",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Helvetica",
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: TextEditingController(),
                            obscureText: false,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Helvetica',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              filled: true,
                              fillColor: const Color(0xff262626),
                              contentPadding: const EdgeInsets.only(
                                left: 12,
                                right: 12,
                                top: 7,
                                bottom: 7,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'OpenSans',
                            ),
                            maxLength: 60,
                          ),
                          Text(
                            "Описание",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 160,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.top,
                              controller: TextEditingController(),
                              obscureText: false,
                              autofocus: false,
                              minLines: null,
                              maxLines: null,
                              expands: true,
                              // keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: '',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Helvetica',
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.4),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                filled: true,
                                fillColor: const Color(0xff262626),
                                contentPadding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 16,
                                  bottom: 16,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'OpenSans',
                              ),
                              maxLength: 60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Теги",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                      ),
                    ),
                    const SizedBox(height: 52),
                    const TagCard(
                      index: 0,
                      value: "goofy",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 29),
                      child: MaterialButton(
                        height: 44,
                        onPressed: () {},
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
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Добавить тег",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const GenreSelector(),
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
                          child: Image.network(
                            'https://freebiesbug.com/wp-content/uploads/2019/05/material-icons-library-580x435.png', // Замените на реальный URL изображения
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const Text('Failed to load image');
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MaterialButton(
                                height: 44,
                                onPressed: () {},
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
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Добавить обложку",
                                      style: TextStyle(
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
            ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Добавить лицензии",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                      ),
                    ),
                    const SizedBox(height: 52),
                    Wrap(
                      spacing: 36.0,
                      runSpacing: 20.0,
                      children: List.generate(4, (index) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: (MediaQuery.of(context).size.width -
                                      200 -
                                      178) /
                                  2),
                          child: const LicenseWidget(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
