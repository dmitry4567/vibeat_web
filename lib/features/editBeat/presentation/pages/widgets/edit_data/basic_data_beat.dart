import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';

class BasicDataBeat extends StatefulWidget {
  const BasicDataBeat({super.key});

  @override
  State<BasicDataBeat> createState() => _BasicDataBeatState();
}

class _BasicDataBeatState extends State<BasicDataBeat> {
  late TextEditingController nameController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    final state = context.read<EditBeatBloc>().state;

    if (state is BeatEditState) {
      nameController = TextEditingController(text: state.beat.name);
      descController = TextEditingController(text: state.beat.description);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

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
                  BlocBuilder<EditBeatBloc, BeatState>(
                    builder: (context, state) {
                      if (state is BeatEditState) {
                        nameController.text = state.beat.name;

                        nameController.selection = TextSelection.fromPosition(
                          TextPosition(offset: nameController.text.length),
                        );

                        return TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: nameController,
                          obscureText: false,
                          autofocus: false,
                          onChanged: (value) {
                            context.read<EditBeatBloc>().add(
                                  ChangeName(name: value),
                                );
                          },
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
                        );
                      }
                      return Container();
                    },
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
                    child: BlocBuilder<EditBeatBloc, BeatState>(
                      builder: (context, state) {
                        if (state is BeatEditState) {
                          descController.text = state.beat.description;

                          descController.selection = TextSelection.fromPosition(
                            TextPosition(offset: descController.text.length),
                          );

                          return TextFormField(
                            textAlignVertical: TextAlignVertical.top,
                            controller: descController,
                            obscureText: false,
                            autofocus: false,
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            onChanged: (value) {
                              context.read<EditBeatBloc>().add(
                                    ChangeDescription(description: value),
                                  );
                            },
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
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
