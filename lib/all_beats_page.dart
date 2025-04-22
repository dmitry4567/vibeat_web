import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:vibeat_web/app/app_router.dart';
import 'package:vibeat_web/responsive.dart';
import 'package:vibeat_web/widgets/tag_widget.dart';

@RoutePage()
class AllBeatsPage extends StatefulWidget {
  const AllBeatsPage({super.key});

  @override
  State<AllBeatsPage> createState() => _AllBeatsPageState();
}

class CategoryType {
  final int index;
  final Color color;
  final String value;

  CategoryType({required this.index, required this.color, required this.value});
}

class _AllBeatsPageState extends State<AllBeatsPage> {
  String? selectedValue;
  final List<CategoryType> items = [
    CategoryType(index: 1, color: Colors.grey, value: "Черновик"),
    CategoryType(
        index: 1, color: const Color(0xffF59E0B), value: "На модерации"),
    CategoryType(index: 3, color: Colors.green, value: "Опубликован"),
    CategoryType(index: 4, color: Colors.blue, value: "Продан"),
    CategoryType(index: 2, color: Colors.red, value: "Не прошел модерацию"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0C0C0C),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Студия / Каталог битов",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "Helvetica",
              ),
            ),
            const Text(
              "Каталог битов",
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: "Helvetica",
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: TextEditingController(),
                    obscureText: false,
                    autofocus: false,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 8),
                        child: Icon(
                          Icons.search,
                          color: const Color(0xffffffff).withOpacity(0.5),
                        ),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.3),
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                      ),
                      hintText: 'Искать по названию',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
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
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: "OpenSans",
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xff262626),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            value: selectedValue,
                            hint: Text(
                              'Выберите категорию',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                            iconStyleData: IconStyleData(
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(
                                  Icons.unfold_more,
                                  size: 16,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue;
                              });
                            },
                            dropdownStyleData: const DropdownStyleData(
                              elevation: 0,
                              decoration: BoxDecoration(
                                color: Color(0xff262626),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                            ),
                            items: items.map<DropdownMenuItem<String>>(
                                (CategoryType category) {
                              return DropdownMenuItem<String>(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: category.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        category.value,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Helvetica",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.crossAxisCount(
                    MediaQuery.of(context).size.width,
                  ),
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: Responsive.childAspectRatio(
                    MediaQuery.of(context).size.width,
                  ),
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return DynamicHeightContainer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicHeightContainer extends StatelessWidget {
  OverlayEntry? _overlayEntry;
  final GlobalKey _buttonKey = GlobalKey(); // Добавляем GlobalKey для кнопки

  DynamicHeightContainer({super.key});

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) {
      return; // Если overlay уже открыт, не открываем новый
    }
    final RenderBox renderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final buttonHeight = renderBox.size.height;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          if (_overlayEntry != null) {
            _overlayEntry!.remove();
            _overlayEntry = null;
          }
        },
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                top: offset.dy - buttonHeight * 4 - 8,
                left: offset.dx - 390,
                child: GestureDetector(
                  onTap: () {},
                  child: Material(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.white.withOpacity(0.05),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 25.0,
                            spreadRadius: 25.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      width: 180,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.router.push(const EditBeatRoute());

                              if (_overlayEntry != null) {
                                _overlayEntry!.remove();
                                _overlayEntry = null;
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color(0xff151515),
                              ),
                              overlayColor: WidgetStateProperty.all(
                                Colors.white10,
                              ),
                              shape: const WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                              ),
                              padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 18,
                              )),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.settings_outlined,
                                  size: 22,
                                  weight: 22,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Редактировать",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_overlayEntry != null) {
                                _overlayEntry?.remove();
                                _overlayEntry =
                                    null; // Set to null after removing
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color(0xff151515),
                              ),
                              overlayColor: WidgetStateProperty.all(
                                Colors.white10,
                              ),
                              shape: const WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                ),
                              ),
                              padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 16,
                              )),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.delete_outline,
                                  size: 22,
                                  weight: 22,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Удалить",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Вставляем Overlay
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageSize = constraints.maxWidth;
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xff151515),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                width: imageSize,
                height: imageSize,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "https://illustrators.ru/uploads/product/image/16737/3082A4C6-D5D3-4CDC-8580-1CA878662A2F.jpeg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Черновик",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Helvetica",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "fse",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenaSans",
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "sefsef",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Helvetica",
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        TagCard(
                          index: 0,
                          value: "rap",
                        ),
                        TagCard(
                          index: 1,
                          value: "rap",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.router.push(const EditBeatRoute());
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xff1e1e1e)),
                          overlayColor: WidgetStateProperty.all(Colors.white10),
                          minimumSize:
                              WidgetStateProperty.all(const Size(34, 34)),
                          fixedSize:
                              WidgetStateProperty.all(const Size(34, 34)),
                          padding: WidgetStateProperty.all(
                            EdgeInsets.zero,
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Редактировать",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Helvetica",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      key: _buttonKey, // Привязываем GlobalKey к кнопке
                      onPressed: () {
                        _showOverlay(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xff1e1e1e)),
                        overlayColor: WidgetStateProperty.all(Colors.white10),
                        minimumSize:
                            WidgetStateProperty.all(const Size(34, 34)),
                        fixedSize: WidgetStateProperty.all(const Size(34, 34)),
                        padding: WidgetStateProperty.all(
                          EdgeInsets.zero,
                        ),
                        elevation: WidgetStateProperty.all(0),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.more_vert,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// class DynamicHeightContainer extends StatelessWidget {
//   OverlayEntry? _overlayEntry;

//   bool _isHovered = false;

//   void _showOverlay(BuildContext context) {
//     final RenderBox renderBox = context.findRenderObject() as RenderBox;
//     final offset = renderBox.localToGlobal(Offset.zero);

//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: 0,
//         left: 0,
//         child: Material(
//           borderRadius: BorderRadius.circular(6),
//           color: Colors.transparent,
//           child: SizedBox(
//             width: 180,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     _overlayEntry?.remove();
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.all(
//                       const Color(0xff262626),
//                     ),
//                     overlayColor: WidgetStateProperty.all(
//                       Colors.white10,
//                     ),
//                     shape: const WidgetStatePropertyAll(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(6),
//                           topRight: Radius.circular(6),
//                         ),
//                       ),
//                     ),
//                     padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(
//                       horizontal: 0,
//                       vertical: 16,
//                     )),
//                   ),
//                   child: Row(
//                     children: [
//                       const SizedBox(width: 14),
//                       Icon(
//                         Icons.settings_outlined,
//                         color: Colors.white.withOpacity(0.5),
//                       ),
//                       const SizedBox(width: 12),
//                       Text(
//                         "Редактировать",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white.withOpacity(0.5),
//                           fontWeight: FontWeight.w400,
//                           fontFamily: "Helvetica",
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _overlayEntry?.remove();
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.all(
//                       const Color(0xff262626),
//                     ),
//                     overlayColor: WidgetStateProperty.all(
//                       Colors.white10,
//                     ),
//                     shape: const WidgetStatePropertyAll(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(6),
//                           bottomRight: Radius.circular(6),
//                         ),
//                       ),
//                     ),
//                     padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(
//                       horizontal: 0,
//                       vertical: 16,
//                     )),
//                   ),
//                   child: Row(
//                     children: [
//                       const SizedBox(width: 14),
//                       Icon(
//                         Icons.delete_outline,
//                         color: Colors.white.withOpacity(0.5),
//                       ),
//                       const SizedBox(width: 12),
//                       Text(
//                         "Удалить",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white.withOpacity(0.5),
//                           fontWeight: FontWeight.w400,
//                           fontFamily: "Helvetica",
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//     Overlay.of(context).insert(_overlayEntry!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double imageSize = constraints.maxWidth;
//         return Container(
//           decoration: const BoxDecoration(
//             color: Color(0xff151515),
//             borderRadius: BorderRadius.all(
//               Radius.circular(8),
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize
//                 .min, // Убедитесь, что Column занимает минимальное пространство
//             children: [
//               // Ваши верхние элементы (например, изображение, текст и т.д.)
//               Container(
//                 padding: const EdgeInsets.all(6),
//                 width: imageSize,
//                 height: imageSize,
//                 decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(8)),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     "https://illustrators.ru/uploads/product/image/16737/3082A4C6-D5D3-4CDC-8580-1CA878662A2F.jpeg",
//                     fit: BoxFit.fitWidth,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 13),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 8,
//                             height: 8,
//                             decoration: const BoxDecoration(
//                               color: Colors.orange,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             "Черновик",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.white.withOpacity(0.8),
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Helvetica",
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "fse",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "OpenaSans",
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       "sefsef",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white.withOpacity(0.5),
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Helvetica",
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Row(
//                       children: [
//                         TagCard(
//                           index: 0,
//                           value: "rap",
//                         ),
//                         TagCard(
//                           index: 1,
//                           value: "rap",
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.all(13.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ButtonStyle(
//                           backgroundColor:
//                               WidgetStateProperty.all(const Color(0xff1e1e1e)),
//                           overlayColor: WidgetStateProperty.all(Colors.white10),
//                           minimumSize:
//                               WidgetStateProperty.all(const Size(34, 34)),
//                           fixedSize:
//                               WidgetStateProperty.all(const Size(34, 34)),
//                           padding: WidgetStateProperty.all(
//                             EdgeInsets.zero,
//                           ),
//                           shape: WidgetStatePropertyAll(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                         child: const Text(
//                           "Редактировать",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: "Helvetica",
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     ElevatedButton(
//                       onPressed: () {
//                         _showOverlay(context);
//                       },
//                       style: ButtonStyle(
//                         backgroundColor:
//                             WidgetStateProperty.all(const Color(0xff1e1e1e)),
//                         overlayColor: WidgetStateProperty.all(Colors.white10),
//                         minimumSize:
//                             WidgetStateProperty.all(const Size(34, 34)),
//                         fixedSize: WidgetStateProperty.all(const Size(34, 34)),
//                         padding: WidgetStateProperty.all(
//                           EdgeInsets.zero,
//                         ),
//                         elevation: WidgetStateProperty.all(0),
//                         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                       ),
//                       child: const Icon(
//                         Icons.more_vert,
//                         size: 20,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }