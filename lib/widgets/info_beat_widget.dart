import 'package:flutter/material.dart';
import 'package:vibeat_web/widgets/tag_widget.dart';

class GenreSelector extends StatefulWidget {
  const GenreSelector({super.key});

  @override
  _GenreSelectorState createState() => _GenreSelectorState();
}

class _GenreSelectorState extends State<GenreSelector> {
  final List<String> allGenres = [
    'Alternative Rock',
    'Ambient',
    'Detroit',
    'Drill',
    'Jerk',
    'Hip-Hop',
    'West Coast',
    'Trap',
    'Super Trap',
    'Hyperpop',
  ];

  List<String> filteredGenres = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  int hoveredIndex = -1; // Индекс наведенного элемента

  @override
  void initState() {
    super.initState();
    filteredGenres = allGenres;
  }

  void filterGenres(String query) {
    setState(() {
      filteredGenres = allGenres
          .where((genre) => genre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: GestureDetector(
        onTap: () {
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
                  fontWeight: FontWeight.w500,
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
                                                searchController.text = '';
                                              });
                                            },
                                            autofocus: isSearching,
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
                                  const Padding(
                                    padding: EdgeInsets.only(top: 13),
                                    child: Row(
                                      children: [
                                        TagCard(index: 0, value: "Ambient"),
                                        TagCard(index: 1, value: "Ambient2"),
                                        TagCard(index: 2, value: "Ambient3"),
                                      ],
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
                                                  index; // Устанавливаем индекс наведенного элемента
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              hoveredIndex =
                                                  -1; // Сбрасываем индекс при уходе курсора
                                            });
                                          },
                                          child: Container(
                                            color: hoveredIndex == index
                                                ? Colors.white.withOpacity(
                                                    0.1) // Подсветка фона
                                                : Colors.transparent,
                                            child: ListTile(
                                              title: Text(
                                                filteredGenres[index],
                                                style: TextStyle(
                                                  color: hoveredIndex == index
                                                      ? Colors
                                                          .white // Подсветка текста
                                                      : Colors.white
                                                          .withOpacity(0.4),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  // searchController.text =
                                                  // filteredGenres[index];
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
                                                searchController.text = '';
                                              });
                                            },
                                            autofocus: isSearching,
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
                                  const Padding(
                                    padding: EdgeInsets.only(top: 13),
                                    child: Row(
                                      children: [
                                        TagCard(index: 0, value: "Ambient"),
                                        TagCard(index: 1, value: "Ambient2"),
                                        TagCard(index: 2, value: "Ambient3"),
                                      ],
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
                                                  index; // Устанавливаем индекс наведенного элемента
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              hoveredIndex =
                                                  -1; // Сбрасываем индекс при уходе курсора
                                            });
                                          },
                                          child: Container(
                                            color: hoveredIndex == index
                                                ? Colors.white.withOpacity(
                                                    0.1) // Подсветка фона
                                                : Colors.transparent,
                                            child: ListTile(
                                              title: Text(
                                                filteredGenres[index],
                                                style: TextStyle(
                                                  color: hoveredIndex == index
                                                      ? Colors
                                                          .white // Подсветка текста
                                                      : Colors.white
                                                          .withOpacity(0.4),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  // searchController.text =
                                                  // filteredGenres[index];
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
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSearching = true;
                              searchController.text = '';
                            });
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
                                          color: Colors.white.withOpacity(0.4),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    onChanged: filterGenres,
                                    onTap: () {
                                      setState(() {
                                        isSearching = true;
                                        searchController.text = '';
                                      });
                                    },
                                    autofocus: isSearching,
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
                                          index; // Устанавливаем индекс наведенного элемента
                                    });
                                  },
                                  onExit: (_) {
                                    setState(() {
                                      hoveredIndex =
                                          -1; // Сбрасываем индекс при уходе курсора
                                    });
                                  },
                                  child: Container(
                                    color: hoveredIndex == index
                                        ? Colors.white
                                            .withOpacity(0.1) // Подсветка фона
                                        : Colors.transparent,
                                    child: ListTile(
                                      title: Text(
                                        filteredGenres[index],
                                        style: TextStyle(
                                          color: hoveredIndex == index
                                              ? Colors.white // Подсветка текста
                                              : Colors.white.withOpacity(0.4),
                                          fontSize: 14,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          // searchController.text =
                                          // filteredGenres[index];
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
                        const Padding(
                          padding: EdgeInsets.only(top: 13),
                          child: Row(
                            children: [
                              TagCard(index: 0, value: "Ambient"),
                              TagCard(index: 1, value: "Ambient2"),
                              TagCard(index: 2, value: "Ambient3"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSearching = true;
                              searchController.text = '';
                            });
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
                                          color: Colors.white.withOpacity(0.4),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    onChanged: filterGenres,
                                    onTap: () {
                                      setState(() {
                                        isSearching = true;
                                        searchController.text = '';
                                      });
                                    },
                                    autofocus: isSearching,
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
                                          index; // Устанавливаем индекс наведенного элемента
                                    });
                                  },
                                  onExit: (_) {
                                    setState(() {
                                      hoveredIndex =
                                          -1; // Сбрасываем индекс при уходе курсора
                                    });
                                  },
                                  child: Container(
                                    color: hoveredIndex == index
                                        ? Colors.white
                                            .withOpacity(0.1) // Подсветка фона
                                        : Colors.transparent,
                                    child: ListTile(
                                      title: Text(
                                        filteredGenres[index],
                                        style: TextStyle(
                                          color: hoveredIndex == index
                                              ? Colors.white // Подсветка текста
                                              : Colors.white.withOpacity(0.4),
                                          fontSize: 14,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          // searchController.text =
                                          // filteredGenres[index];
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
                        const Padding(
                          padding: EdgeInsets.only(top: 13),
                          child: Row(
                            children: [
                              TagCard(index: 0, value: "Ambient"),
                              TagCard(index: 1, value: "Ambient2"),
                              TagCard(index: 2, value: "Ambient3"),
                            ],
                          ),
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
