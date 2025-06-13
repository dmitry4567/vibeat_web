import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/features/editLicense/presentation/bloc/edit_license_template_bloc.dart';
import 'package:vibeat_web/features/editLicense/presentation/widgets/conditions_widget.dart';

class DistributingDataLicense extends StatefulWidget {
  const DistributingDataLicense({super.key});

  @override
  State<DistributingDataLicense> createState() =>
      DdistributingDataStateLicense();
}

class DdistributingDataStateLicense extends State<DistributingDataLicense> {
  bool musicRecording = false;
  bool liveProfit = false;

  late TextEditingController distributeCopiesController;
  late TextEditingController audioStreamsController;
  late TextEditingController radioBroadcastingController;
  late TextEditingController musicVideosController;

  bool _unlimDistributeCopies = false;
  bool _unlimAudioStreams = false;
  bool _unlimRadioBroadcasting = false;
  bool _unlimMusicVideos = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<EditLicenseTemplateBloc>().state;

    if (state is EditLicenseTemplateState) {
      musicRecording = state.templateLicense.musicRecording;
      liveProfit = state.templateLicense.liveProfit;

      _unlimDistributeCopies = state.templateLicense.unlimDistributeCopies;
      distributeCopiesController = TextEditingController(
          text: _unlimDistributeCopies
              ? ""
              : state.templateLicense.distributeCopies.toString());

      _unlimAudioStreams = state.templateLicense.unlimAudioStreams;
      audioStreamsController = TextEditingController(
          text: _unlimAudioStreams
              ? ""
              : state.templateLicense.audioStreams.toString());

      _unlimRadioBroadcasting = state.templateLicense.unlimRadioBroadcasting;
      radioBroadcastingController = TextEditingController(
          text: _unlimRadioBroadcasting
              ? ""
              : state.templateLicense.radioBroadcasting.toString());

      _unlimMusicVideos = state.templateLicense.unlimMusicVideos;
      musicVideosController = TextEditingController(
          text: _unlimMusicVideos
              ? ""
              : state.templateLicense.musicVideos.toString());
    }
  }

  @override
  void dispose() {
    distributeCopiesController.dispose();
    audioStreamsController.dispose();
    radioBroadcastingController.dispose();
    musicVideosController.dispose();
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
              "Условия создания и распространения",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "OpenSans",
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ConditionsWidget(
                    title: "Запись музыки",
                    description:
                        "Укажите, разрешавете ли вы запись музыки при\nналичии данной лицензии",
                    value: musicRecording,
                    onChanged: (value) {
                      setState(() => musicRecording = value);
                      context.read<EditLicenseTemplateBloc>().add(
                            UpdateMusicRecordingEvent(value),
                          );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ConditionsWidget(
                    title: "Коммерческие выступления",
                    description:
                        "Укажите, разрешаете ли вы коммерческие выступления при\nналичии данной лицензии",
                    value: liveProfit,
                    onChanged: (value) {
                      setState(() => liveProfit = value);
                      context.read<EditLicenseTemplateBloc>().add(
                            UpdateLiveProfitEvent(value),
                          );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Количество проданных копий",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Helvetica",
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      BlocBuilder<EditLicenseTemplateBloc,
                          LicenseTemplateState>(
                        builder: (context, state) {
                          if (state is EditLicenseTemplateState) {
                            distributeCopiesController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset:
                                      distributeCopiesController.text.length),
                            );

                            return TextFormField(
                              keyboardType: TextInputType.number,
                              textAlignVertical: TextAlignVertical.center,
                              controller: distributeCopiesController,
                              onChanged: (value) {
                                context.read<EditLicenseTemplateBloc>().add(
                                      UpdateDistributeCopiesEvent(
                                          int.parse(value)),
                                    );
                              },
                              canRequestFocus: !_unlimDistributeCopies,
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
                                    color: _unlimDistributeCopies
                                        ? Colors.white.withOpacity(0.05)
                                        : Colors.white.withOpacity(0.2),
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
                                fillColor: _unlimDistributeCopies
                                    ? const Color(0xff262626).withOpacity(0.5)
                                    : const Color(0xff262626),
                                contentPadding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 7,
                                  bottom: 7,
                                ),
                              ),
                              style: TextStyle(
                                color: _unlimDistributeCopies
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white,
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'OpenSans',
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _unlimDistributeCopies,
                                onChanged: (value) {
                                  setState(() {
                                    _unlimDistributeCopies =
                                        !_unlimDistributeCopies;
                                  });
                                  context.read<EditLicenseTemplateBloc>().add(
                                        UpdateUnlimDistributeCopiesEvent(
                                            _unlimDistributeCopies),
                                      );
                                },
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Безлимитно",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Количество прослушиваний на стриминговых платформах",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Helvetica",
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      BlocBuilder<EditLicenseTemplateBloc,
                          LicenseTemplateState>(
                        builder: (context, state) {
                          if (state is EditLicenseTemplateState) {
                            audioStreamsController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: audioStreamsController.text.length),
                            );

                            return TextFormField(
                              keyboardType: TextInputType.number,
                              textAlignVertical: TextAlignVertical.center,
                              controller: audioStreamsController,
                              onChanged: (value) {
                                context.read<EditLicenseTemplateBloc>().add(
                                      UpdateAudioStreamsEvent(
                                          int.parse(value)),
                                    );
                              },
                              canRequestFocus: !_unlimAudioStreams,
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
                                    color: _unlimAudioStreams
                                        ? Colors.white.withOpacity(0.05)
                                        : Colors.white.withOpacity(0.2),
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
                                fillColor: _unlimAudioStreams
                                    ? const Color(0xff262626).withOpacity(0.5)
                                    : const Color(0xff262626),
                                contentPadding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 7,
                                  bottom: 7,
                                ),
                              ),
                              style: TextStyle(
                                color: _unlimAudioStreams
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white,
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'OpenSans',
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _unlimAudioStreams,
                                onChanged: (value) {
                                  setState(() {
                                    _unlimAudioStreams = !_unlimAudioStreams;
                                  });
                                  context.read<EditLicenseTemplateBloc>().add(
                                        UpdateUnlimAudioStreamsEvent(
                                            _unlimAudioStreams),
                                      );
                                },
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Безлимитно",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Количество радиостанций",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Helvetica",
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      BlocBuilder<EditLicenseTemplateBloc,
                          LicenseTemplateState>(
                        builder: (context, state) {
                          if (state is EditLicenseTemplateState) {
                            radioBroadcastingController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset:
                                      radioBroadcastingController.text.length),
                            );

                            return TextFormField(
                              keyboardType: TextInputType.number,
                              textAlignVertical: TextAlignVertical.center,
                              controller: radioBroadcastingController,
                              onChanged: (value) {
                                context.read<EditLicenseTemplateBloc>().add(
                                      UpdateRadioBroadcastingEvent(
                                          int.parse(value)),
                                    );
                              },
                              canRequestFocus: !_unlimRadioBroadcasting,
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
                                    color: _unlimRadioBroadcasting
                                        ? Colors.white.withOpacity(0.05)
                                        : Colors.white.withOpacity(0.2),
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
                                fillColor: _unlimRadioBroadcasting
                                    ? const Color(0xff262626).withOpacity(0.5)
                                    : const Color(0xff262626),
                                contentPadding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 7,
                                  bottom: 7,
                                ),
                              ),
                              style: TextStyle(
                                color: _unlimRadioBroadcasting
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white,
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'OpenSans',
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _unlimRadioBroadcasting,
                                onChanged: (value) {
                                  setState(() {
                                    _unlimRadioBroadcasting =
                                        !_unlimRadioBroadcasting;
                                  });
                                  context.read<EditLicenseTemplateBloc>().add(
                                        UpdateUnlimRadioBroadcastingEvent(
                                            _unlimRadioBroadcasting),
                                      );
                                },
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Безлимитно",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Количество музыкальных видео",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Helvetica",
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      BlocBuilder<EditLicenseTemplateBloc,
                          LicenseTemplateState>(
                        builder: (context, state) {
                          if (state is EditLicenseTemplateState) {
                            musicVideosController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: musicVideosController.text.length),
                            );

                            return TextFormField(
                              keyboardType: TextInputType.number,
                              textAlignVertical: TextAlignVertical.center,
                              controller: musicVideosController,
                              onChanged: (value) {
                                context.read<EditLicenseTemplateBloc>().add(
                                      UpdateMusicVideosEvent(int.parse(value)),
                                    );
                              },
                              canRequestFocus: !_unlimMusicVideos,
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
                                    color: _unlimMusicVideos
                                        ? Colors.white.withOpacity(0.05)
                                        : Colors.white.withOpacity(0.2),
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
                                fillColor: _unlimMusicVideos
                                    ? const Color(0xff262626).withOpacity(0.5)
                                    : const Color(0xff262626),
                                contentPadding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 7,
                                  bottom: 7,
                                ),
                              ),
                              style: TextStyle(
                                color: _unlimMusicVideos
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white,
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'OpenSans',
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _unlimMusicVideos,
                                onChanged: (value) {
                                  setState(() {
                                    _unlimMusicVideos = !_unlimMusicVideos;
                                  });
                                  context.read<EditLicenseTemplateBloc>().add(
                                        UpdateUnlimMusicVideosEvent(
                                            _unlimMusicVideos),
                                      );
                                },
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Безлимитно",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w400,
                                fontFamily: "OpenSans",
                              ),
                            ),
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
    );
  }
}
