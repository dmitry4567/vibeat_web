import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vibeat_web/app/app_router.dart';
import 'package:vibeat_web/custom_functions.dart';
import 'package:vibeat_web/features/anketa/domain/entities/anketa_entity.dart';
import 'package:vibeat_web/features/anketa/presentation/bloc/anketa_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AnketaPage extends StatefulWidget {
  const AnketaPage({super.key});

  @override
  State<AnketaPage> createState() => _AnketaPageState();
}

class _AnketaPageState extends State<AnketaPage> {
  @override
  void initState() {
    super.initState();

    context.read<AnketaBloc>().add(GetAnketaEvent());
  }

  @override
  Widget build(BuildContext context) {
    const double paddingWidth = 18.0;

    return BlocConsumer<AnketaBloc, AnketaState>(
      listener: (context, state) {
        if (state.status == AnketaStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(setupSnackBar(state.errorMessage!));
        }
        if (state.isResponseSuccess == true) {
          context.router.replaceAll([const HomeRoute()]);
        }
      },
      builder: (context, state) {
        if (state.status == AnketaStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.anketa != null) {
          return Scaffold(
            backgroundColor: const Color(0xff0C0C0C),
            body: Center(
              child: Container(
                width: 800,
                height: 700,
                decoration: BoxDecoration(
                  color: const Color(0xff191919),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 32, bottom: 32),
                      child: const Text(
                        "Выберите любимые жанры",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                    ),
                    // Прокручиваемая область
                    Expanded(
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.only(
                              left: paddingWidth,
                              right: paddingWidth,
                              bottom: 100,
                            ),
                            sliver: SliverGrid.builder(
                              itemCount: state.anketa!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisExtent: 100,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                              itemBuilder: (context, index) => Skeletonizer(
                                enabled: false,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: CardGenre(
                                    index: index,
                                    text: state.anketa![index].text,
                                    genre: state.anketa![index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 56,
                      margin: const EdgeInsets.only(
                        left: 18,
                        right: 18,
                        bottom: 20,
                        top: 20,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AnketaBloc>().add(
                                const SendAnketaResponseEvent(),
                              );
                        },
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.disabled)) {
                                return Colors
                                    .grey; // Серый цвет, если кнопка отключена
                              }
                              return const Color(0xff8D40FF);
                            },
                          ),
                          foregroundColor:
                              WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.disabled)) {
                                // return AppColors
                                //     .textPrimary; // Белый текст, если отключена
                              }
                              return Colors.black; // Чёрный текст, если активна
                            },
                          ),
                          overlayColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.pressed)) {
                                return Colors.white
                                    .withOpacity(0.1); // Белый splash-эффект
                              }
                              return Colors
                                  .transparent; // Прозрачный, если не нажата
                            },
                          ),
                        ),
                        child: const Text(
                          'Далее',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            height: 1,
                          ),
                          // style: AppTextStyles.buttonTextField,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(
          child: Text('Неизвестный статус анкеты'),
        );
      },
    );
  }
}

class CardGenre extends StatefulWidget {
  const CardGenre(
      {super.key,
      required this.index,
      required this.text,
      required this.genre});

  final int index;
  final String text;
  final AnketaEntity genre;

  @override
  State<CardGenre> createState() => _CardGenreState();
}

class _CardGenreState extends State<CardGenre> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;

          context.read<AnketaBloc>().add(
                AddGenreEvent(
                  genre: widget.genre,
                ),
              );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: isSelected
                  ? const Color(0xff8D40FF)
                  : Colors.white.withOpacity(0.1),
              width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/genre${((widget.index + 1) % 4 + 1).toInt()}.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              Positioned(
                top: 9,
                left: 9,
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: -0.41,
                    height: 0.81,
                  ),
                ),
              ),
              isSelected
                  ? const Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        Icons.check_circle,
                        color: Color(0xff8D40FF),
                        size: 20,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
