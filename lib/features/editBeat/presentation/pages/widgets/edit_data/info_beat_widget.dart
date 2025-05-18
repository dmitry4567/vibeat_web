import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/tag_widget.dart';

class GenreSelector extends StatefulWidget {
  const GenreSelector({super.key});

  @override
  _GenreSelectorState createState() => _GenreSelectorState();
}

class _GenreSelectorState extends State<GenreSelector> {
  List<GenreEntity> allGenres = [];
  List<GenreEntity> filteredGenres = [];
  List<GenreEntity> selectedGenres = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  bool isSearching = false;
  int hoveredIndex = -1;

  List<MoodEntity> allMoods = [];
  List<MoodEntity> filteredMoods = [];
  List<MoodEntity> selectedMoods = [];
  TextEditingController searchController2 = TextEditingController();
  bool isLoading2 = true;
  bool isSearching2 = false;
  int hoveredIndex2 = -1;

  List<KeyEntity> allKeys = [];
  List<KeyEntity> filteredKeys = [];
  KeyEntity? selectedKey;
  TextEditingController searchController3 = TextEditingController();
  bool isLoading3 = true;
  bool isSearching3 = false;
  int hoveredIndex3 = -1;

  int bpm = 0;
  TextEditingController searchController4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<EditBeatBloc>();
    if (bloc.state is BeatEditState) {
      final state = bloc.state as BeatEditState;
      selectedGenres = List<GenreEntity>.from(state.beat.genres);
      selectedMoods = List<MoodEntity>.from(state.beat.moods);
      selectedKey = state.beat.key;
      bpm = state.beat.bpm;
      searchController4.text = bpm.toString();
    }
    fetchGenres();
    fetchMoods();
    fetchKeys();
  }

  void filterGenres(String query) {
    setState(() {
      filteredGenres = allGenres
          .where(
              (genre) => genre.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterMoods(String query) {
    setState(() {
      filteredMoods = allMoods
          .where(
              (mood) => mood.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterKeys(String query) {
    setState(() {
      filteredKeys = allKeys
          .where((key) => key.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addGenre(GenreEntity genre) {
    setState(() {
      if (!selectedGenres.any((selected) => selected.id == genre.id)) {
        selectedGenres.add(genre);
        final bloc = context.read<EditBeatBloc>();
        bloc.add(ChangeGenres(genres: selectedGenres));
      }
    });
  }

  void _addMood(MoodEntity mood) {
    setState(() {
      if (!selectedMoods.any((selected) => selected.id == mood.id)) {
        selectedMoods.add(mood);
        final bloc = context.read<EditBeatBloc>();
        bloc.add(ChangeMoods(moods: selectedMoods));
      }
    });
  }

  void _addKey(KeyEntity key) {
    setState(() {
      selectedKey = key;
      final bloc = context.read<EditBeatBloc>();
      bloc.add(ChangeKey(key: key));
    });
  }

  void _changeBpm(int value) {
    setState(() {
      bpm = value;
      final bloc = context.read<EditBeatBloc>();
      bloc.add(ChangeBpm(bpm: value));
    });
  }

  Future<void> fetchGenres() async {
    final dio = Dio();
    setState(() => isLoading = true);

    try {
      final response = await dio.get(
        "http://192.168.0.135:7772/api/metadata/genres",
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        setState(() {
          allGenres = data.map((genre) => GenreEntity.fromJson(genre)).toList();
          filteredGenres = allGenres;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching genres: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchMoods() async {
    final dio = Dio();
    setState(() => isLoading2 = true);

    try {
      final response = await dio.get(
        "http://192.168.0.135:7772/api/metadata/moods",
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        setState(() {
          allMoods = data.map((mood) => MoodEntity.fromJson(mood)).toList();
          filteredMoods = allMoods;
          isLoading2 = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching genres: $e');
      setState(() => isLoading2 = false);
    }
  }

  Future<void> fetchKeys() async {
    final dio = Dio();
    setState(() => isLoading3 = true);

    try {
      final response = await dio.get(
        "http://192.168.0.135:7772/api/metadata/keynotes",
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        setState(() {
          allKeys = data.map((key) => KeyEntity.fromJson(key)).toList();
          filteredKeys = allKeys;
          isLoading3 = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching genres: $e');
      setState(() => isLoading3 = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Скрыть клавиатуру при нажатии вне поля
          setState(() {
            isSearching = false;
          });
        },
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
                "Параметры",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans",
                ),
              ),
              const SizedBox(height: 52),
              Row(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSearching = true;
                                      searchController.text = '';
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff262626),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: searchController,
                                            decoration: InputDecoration(
                                                hintText: 'Выберите жанр',
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.4),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            onChanged: filterGenres,
                                            onTap: () {
                                              setState(() {
                                                isSearching = true;
                                                searchController.clear();
                                                filterGenres('');
                                              });
                                            },
                                            autofocus: isSearching,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.unfold_more,
                                          size: 16,
                                          color: Colors.white.withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (!isSearching)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 13),
                                    child: SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: selectedGenres.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: TagCard(
                                                index: index,
                                                value:
                                                    selectedGenres[index].name,
                                                delete: () {
                                                  setState(() {
                                                    selectedGenres
                                                        .removeAt(index);
                                                    final bloc = context
                                                        .read<EditBeatBloc>();

                                                    bloc.add(ChangeGenres(
                                                        genres:
                                                            selectedGenres));
                                                  });
                                                }),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                if (isSearching)
                                  Container(
                                    height: 280,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff262626),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: ListView.builder(
                                      itemCount: filteredGenres.length,
                                      itemBuilder: (context, index) {
                                        return MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              hoveredIndex =
                                                  index; // Только подсветка при наведении
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              hoveredIndex = -1;
                                            });
                                          },
                                          child: Container(
                                            color: hoveredIndex == index
                                                ? Colors.white.withOpacity(0.1)
                                                : Colors.transparent,
                                            child: ListTile(
                                              title: Text(
                                                filteredGenres[index].name,
                                                style: TextStyle(
                                                  color: hoveredIndex == index
                                                      ? Colors.white
                                                      : Colors.white
                                                          .withOpacity(0.4),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  if (!selectedGenres.any(
                                                      (selected) =>
                                                          selected.id ==
                                                          filteredGenres[index]
                                                              .id)) {
                                                    _addGenre(
                                                        filteredGenres[index]);
                                                  }
                                                  searchController.text = '';
                                                  isSearching = false;
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSearching2 = true;
                                      searchController2.text = '';
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff262626),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: searchController2,
                                            decoration: InputDecoration(
                                                hintText: 'Выберите настроение',
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.4),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            onChanged: filterMoods,
                                            onTap: () {
                                              setState(() {
                                                isSearching2 = true;
                                                searchController2.clear();
                                                filterMoods('');
                                              });
                                            },
                                            autofocus: isSearching2,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.unfold_more,
                                          size: 16,
                                          color: Colors.white.withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (!isSearching2)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 13),
                                    child: SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: selectedMoods.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: TagCard(
                                                index: index,
                                                value:
                                                    selectedMoods[index].name,
                                                delete: () {
                                                  setState(() {
                                                    selectedMoods
                                                        .removeAt(index);
                                                    final bloc = context
                                                        .read<EditBeatBloc>();

                                                    bloc.add(ChangeMoods(
                                                        moods: selectedMoods));
                                                  });
                                                }),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                if (isSearching2)
                                  Container(
                                    height: 280,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff262626),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: ListView.builder(
                                      itemCount: filteredMoods.length,
                                      itemBuilder: (context, index) {
                                        return MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              hoveredIndex2 =
                                                  index; // Только подсветка при наведении
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              hoveredIndex2 = -1;
                                            });
                                          },
                                          child: Container(
                                            color: hoveredIndex2 == index
                                                ? Colors.white.withOpacity(0.1)
                                                : Colors.transparent,
                                            child: ListTile(
                                              title: Text(
                                                filteredMoods[index].name,
                                                style: TextStyle(
                                                  color: hoveredIndex2 == index
                                                      ? Colors.white
                                                      : Colors.white
                                                          .withOpacity(0.4),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  if (!selectedMoods.any(
                                                      (selected) =>
                                                          selected.id ==
                                                          filteredMoods[index]
                                                              .id)) {
                                                    _addMood(
                                                        filteredMoods[index]);
                                                  }
                                                  searchController2.text = '';
                                                  isSearching2 = false;
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSearching3 = true;
                                      searchController3.text = '';
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff262626),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: searchController3,
                                            decoration: InputDecoration(
                                                hintText: selectedKey == null
                                                    ? 'Выберите тональность'
                                                    : selectedKey!.name
                                                        .toString(),
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.4),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            onChanged: filterKeys,
                                            onTap: () {
                                              setState(() {
                                                isSearching3 = true;
                                                searchController3.clear();
                                                filterKeys('');
                                              });
                                            },
                                            autofocus: isSearching3,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.unfold_more,
                                          size: 16,
                                          color: Colors.white.withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // if (!isSearching3)
                                //   Padding(
                                //     padding: const EdgeInsets.only(top: 13),
                                //     child: SizedBox(
                                //       height: 40,
                                //       child: ListView.builder(
                                //         scrollDirection: Axis.horizontal,
                                //         itemCount: selectedKeys.length,
                                //         itemBuilder: (context, index) {
                                //           return Padding(
                                //             padding: const EdgeInsets.only(
                                //                 right: 8.0),
                                //             child: TagCard(
                                //                 index: index,
                                //                 value: selectedKeys[index].name,
                                //                 delete: () {
                                //                   setState(() {
                                //                     selectedKeys
                                //                         .removeAt(index);
                                //                     final bloc = context
                                //                         .read<EditBeatBloc>();

                                //                     bloc.add(ChangeKey(
                                //                         key: selectedKeys));
                                //                   });
                                //                 }),
                                //           );
                                //         },
                                //       ),
                                //     ),
                                //   ),
                                if (isSearching3)
                                  Container(
                                    height: 280,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff262626),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: ListView.builder(
                                      itemCount: filteredKeys.length,
                                      itemBuilder: (context, index) {
                                        return MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              hoveredIndex3 =
                                                  index; // Только подсветка при наведении
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              hoveredIndex3 = -1;
                                            });
                                          },
                                          child: Container(
                                            color: hoveredIndex3 == index
                                                ? Colors.white.withOpacity(0.1)
                                                : Colors.transparent,
                                            child: ListTile(
                                              title: Text(
                                                filteredKeys[index].name,
                                                style: TextStyle(
                                                  color: hoveredIndex == index
                                                      ? Colors.white
                                                      : Colors.white
                                                          .withOpacity(0.4),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _addKey(filteredKeys[index]);
                                                  searchController3.text = '';
                                                  isSearching3 = false;
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff262626),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: searchController4,
                                            decoration: InputDecoration(
                                                hintText: 'Введите BPM',
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.4),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            onChanged: (value) {
                                              int bpm =
                                                  int.tryParse(value) ?? 0;
                                              _changeBpm(bpm);
                                            },
                                            autofocus: isSearching,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
