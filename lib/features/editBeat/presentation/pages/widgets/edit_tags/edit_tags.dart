import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/features/allBeats/data/models/beat_model.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/tag_widget.dart';

class EditTags extends StatefulWidget {
  const EditTags({super.key});

  @override
  State<EditTags> createState() => _EditTagsState();
}

class _EditTagsState extends State<EditTags> {
  @override
  Widget build(BuildContext context) {
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
              "Теги",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "OpenSans",
              ),
            ),
            const SizedBox(height: 52),
            BlocBuilder<EditBeatBloc, BeatState>(
              builder: (context, state) {
                if (state is BeatEditState) {
                  return SizedBox(
                    height: 35,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.beat.tags.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TagCard(
                          index: index,
                          value: state.beat.tags[index].name,
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 29),
              child: MaterialButton(
                height: 44,
                onPressed: () async {
                  await tagDialog(context).then((value) {
                    if (value != null) {
                      final currentState = context.read<EditBeatBloc>().state;

                      if (currentState is BeatEditState) {
                        context.read<EditBeatBloc>().add(
                              ChangeTags(
                                tags: value as List<TagEntity>,
                              ),
                            );
                      }
                    }
                  });
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
    );
  }
}

Future<List<TagEntity>?> tagDialog(BuildContext context) async {
// Capture the EditBeatBloc instance before showing dialog
  final bloc = context.read<EditBeatBloc>();
  List<TagEntity> initialTags = [];

  if (bloc.state is BeatEditState) {
    initialTags = List<TagEntity>.from((bloc.state as BeatEditState).beat.tags);
  }

  return showDialog<List<TagEntity>>(
    context: context,
    builder: (BuildContext dialogContext) {
      // Create new BlocProvider with captured bloc instance
      return BlocProvider.value(
        value: bloc, // Use the captured bloc instance
        child: Builder(
          builder: (builderContext) {
            TextEditingController tagController = TextEditingController();
            List<TagEntity> selectedTags = initialTags;
            List<TagEntity> availableTags = [];
            bool isLoading = true;

            Future<void> getAllTags() async {
              final dio = Dio();
              try {
                final response = await dio.get(
                  "http://192.168.0.135:7772/api/metadata/tags",
                  options: Options(headers: {
                    'Content-Type': 'application/json',
                  }),
                );

                if (response.statusCode == 200) {
                  // Assuming the response data is a List<String> of tag names
                  final json = response.data['data'] as List<dynamic>;

                  availableTags =
                      json.map((tag) => TagEntity.fromJson(tag)).toList();
                }
              } catch (e) {
                log('Error fetching tags: $e');
              }
            }

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                // Load tags when dialog opens
                if (isLoading) {
                  getAllTags().then((_) {
                    setState(() {
                      isLoading = false;
                    });
                  });
                }

                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: 500,
                    height: 400,
                    decoration: const BoxDecoration(
                      color: Color(0xff151515),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: tagController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: "Поиск тега",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      // Filter tags based on search
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xff8D40FF),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: availableTags.length,
                                      itemBuilder: (context, index) {
                                        final tag = availableTags[index];
                                        final isSelected = selectedTags
                                            .any((t) => t.id == tag.id);

                                        return ListTile(
                                          title: Text(
                                            tag.name,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          trailing: isSelected
                                              ? const Icon(
                                                  Icons.check_circle,
                                                  color: Color(0xff8D40FF),
                                                )
                                              : const Icon(
                                                  Icons.circle_outlined,
                                                  color: Colors.grey,
                                                ),
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                selectedTags.removeWhere((t) =>
                                                    t.id ==
                                                    tag.id);
                                              } else {
                                                selectedTags.add(tag);
                                              }
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Отмена',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, selectedTags);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff8D40FF),
                                ),
                                child: const Text('Сохранить',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    },
  );
}

// void tagDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       TextEditingController tagController = TextEditingController();
//       List<String> tags = [];

//       void getAllTags() async {
//         final dio = Dio();

//         final response = await dio.get(
//           "http://192.168.0.135:7772/api/metadata/tags",
//           options: Options(headers: {
//             'Content-Type': 'application/json',
//           }),
//         );

//         log(response.data.toString());
//       }

//       return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return Dialog(
//             backgroundColor: Colors.transparent,
//             child: Container(
//               width: 500, // Фиксированная ширина
//               height: 400, // Фиксированная высота
//               decoration: const BoxDecoration(
//                 color: Color(0xff151515),
//                 borderRadius: BorderRadius.all(Radius.circular(12)),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: tagController,
//                             style: const TextStyle(color: Colors.white),
//                             decoration: const InputDecoration(
//                               hintText: "Введите тег",
//                               hintStyle: TextStyle(color: Colors.grey),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () {
//                             if (tagController.text.isNotEmpty) {
//                               setState(() {
//                                 tags.add(tagController.text);
//                                 tagController.clear();
//                               });
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xff8D40FF),
//                           ),
//                           child: const Text(
//                             "Добавить",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border:
//                               Border.all(color: Colors.grey.withOpacity(0.2)),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: tags.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               title: Text(
//                                 tags[index],
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                               trailing: IconButton(
//                                 icon:
//                                     const Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () {
//                                   setState(() {
//                                     tags.removeAt(index);
//                                   });
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text(
//                             'Отмена',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Здесь можно добавить логику сохранения тегов
//                             Navigator.pop(context, tags);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xff8D40FF),
//                           ),
//                           child: const Text('Сохранить',
//                               style: TextStyle(color: Colors.white)),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }
