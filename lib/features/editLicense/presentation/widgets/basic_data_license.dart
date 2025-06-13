import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/features/editLicense/presentation/bloc/edit_license_template_bloc.dart';

class BasicDataLicense extends StatefulWidget {
  const BasicDataLicense({super.key});

  @override
  State<BasicDataLicense> createState() => _BasicDataLicenseState();
}

class _BasicDataLicenseState extends State<BasicDataLicense> {
  late TextEditingController nameController;
  late TextEditingController descController;

  bool mp3 = false;
  bool wav = false;
  bool zip = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<EditLicenseTemplateBloc>().state;

    if (state is EditLicenseTemplateState) {
      nameController = TextEditingController(text: state.templateLicense.name);
      descController =
          TextEditingController(text: state.templateLicense.description);
      mp3 = state.templateLicense.mp3;
      wav = state.templateLicense.wav;
      zip = state.templateLicense.zip;
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
              width: 545, //?
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Название лицензии",
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
                  BlocBuilder<EditLicenseTemplateBloc, LicenseTemplateState>(
                    builder: (context, state) {
                      if (state is EditLicenseTemplateState) {
                        nameController.text = state.templateLicense.name;

                        nameController.selection = TextSelection.fromPosition(
                          TextPosition(offset: nameController.text.length),
                        );

                        return TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: nameController,
                          onChanged: (value) {
                            context.read<EditLicenseTemplateBloc>().add(
                                  ChangeName(name: value),
                                );
                          },
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
                        );
                      }
                      return Container();
                    },
                  ),
                  Text(
                    "Описание лицензии",
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
                    height: 120,
                    child: BlocBuilder<EditLicenseTemplateBloc,
                        LicenseTemplateState>(
                      builder: (context, state) {
                        if (state is EditLicenseTemplateState) {
                          descController.text =
                              state.templateLicense.description;

                          descController.selection = TextSelection.fromPosition(
                            TextPosition(offset: descController.text.length),
                          );

                          return TextFormField(
                            textAlignVertical: TextAlignVertical.top,
                            controller: descController,
                            onChanged: (value) {
                              context.read<EditLicenseTemplateBloc>().add(
                                    ChangeDescription(description: value),
                                  );
                            },
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
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  Text(
                    "Предоставляемые файлы",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                          right: 28,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: mp3,
                                onChanged: (value) {
                                  setState(
                                    () => mp3 = !mp3,
                                  );
                                  context
                                      .read<EditLicenseTemplateBloc>()
                                      .add(UpdateMp3Event(mp3));
                                },
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "MP3",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                          right: 28,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: wav,
                                onChanged: (value) {
                                  setState(
                                    () => wav = !wav,
                                  );
                                  context
                                      .read<EditLicenseTemplateBloc>()
                                      .add(UpdateWavEvent(wav));
                                },
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "WAV",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                          right: 28,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: zip,
                                onChanged: (value) {
                                  setState(
                                    () => zip = !zip,
                                  );
                                  context
                                      .read<EditLicenseTemplateBloc>()
                                      .add(UpdateZipEvent(zip));
                                },
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "TRACKOUT (STEMS)",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Helvetica",
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
          ],
        ),
      ),
    );
  }
}
