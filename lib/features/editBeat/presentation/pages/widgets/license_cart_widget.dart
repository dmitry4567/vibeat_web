import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';

class LicenseWidget extends StatefulWidget {
  const LicenseWidget({super.key});

  @override
  State<LicenseWidget> createState() => _LicenseWidgetState();
}

class _LicenseWidgetState extends State<LicenseWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBeatBloc, BeatState>(
      builder: (context, state) {
        return state is BeatEditState
            ? Wrap(
                spacing: 36.0,
                runSpacing: 20.0,
                children: List.generate(
                  state.templateLicense.length,
                  (index) {
                    List<String> availableFiles = [];

                    if (state.templateLicense[index].mp3) {
                      availableFiles.add("MP3");
                    }
                    if (state.templateLicense[index].wav) {
                      availableFiles.add("WAV");
                    }
                    if (state.templateLicense[index].zip) {
                      availableFiles.add("TRACKOUT");
                    }

                    String availableFilesString = availableFiles.join(", ");
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth:
                              (MediaQuery.of(context).size.width - 200 - 178) /
                                  2),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: state.templateLicense[index].isActive
                              ? const Color(0xff1E1E1E)
                              : const Color(0xff1E1E1E).withOpacity(0.4),
                          border: Border.all(
                            color: state.templateLicense[index].isActive
                                ? const Color(0xffffffff).withOpacity(0.1)
                                : const Color(0xffffffff).withOpacity(0.05),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.templateLicense[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: state.templateLicense[index].isActive
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "OpenSans",
                                  ),
                                ),
                                Text(
                                  availableFilesString,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: state.templateLicense[index].isActive
                                        ? Colors.white.withOpacity(0.6)
                                        : Colors.white.withOpacity(0.4),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "OpenSans",
                                    height: 1.8,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible:
                                      state.templateLicense[index].isActive,
                                  child: SizedBox(
                                    width: 75,
                                    height: 45,
                                    child: TextFormField(
                                      enabled:
                                          state.templateLicense[index].isActive,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(4),
                                      ],
                                      controller: TextEditingController(
                                          text: state
                                              .templateLicense[index].price
                                              .toString()),
                                      obscureText: false,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        // hintText: 'RUB',
                                        prefixText: "₽",
                                        prefixStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Helvetica',
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.4),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Helvetica',
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Colors.white.withOpacity(0.05),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                        fontSize: 16,
                                        height: 1,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                      onChanged: (value) {
                                        // setState(() {
                                        state.templateLicense[index].price =
                                            int.parse(value.toString());
                                        // });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Switch(
                                  trackColor: WidgetStateProperty.resolveWith(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return const Color(0xff8D40FF);
                                      }
                                      return const Color(0xffE6E0E9);
                                    },
                                  ),
                                  thumbColor: WidgetStateProperty.resolveWith(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return HSLColor.fromColor(Colors.white)
                                            .toColor();
                                      }
                                      return const Color(0xff79747E);
                                    },
                                  ),
                                  splashRadius: 24,
                                  value: state.templateLicense[index].isActive,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      // if (newValue) {
                                      //   _controller.text = "0";
                                      // }
                                      state.templateLicense[index].isActive =
                                          newValue;
                                      // widget.license.isActive = newValue;
                                      state.templateLicense[index].price = 0;
                                      // widget.license.price = 0;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container();
      },
    );
  }
}