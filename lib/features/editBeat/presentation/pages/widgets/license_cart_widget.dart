import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibeat_web/app/injection_container.dart';
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';

class LicenseWidget extends StatefulWidget {
  const LicenseWidget({super.key});

  @override
  State<LicenseWidget> createState() => _LicenseWidgetState();
}

class _LicenseWidgetState extends State<LicenseWidget> {
  int price = 0;

  List<LicenseTemplateEntity> license = [];
  ApiClient apiClient = sl<ApiClient>();
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();

    getTemplateLicense();
  }

  void getTemplateLicense() async {
    final response = await apiClient.get(
      "license/allLicenseTemplatesByBeatmakerJWT",
      options: Options(),
    );

    if (response.statusCode == 200) {
      final data = response.data['data'];
      setState(() {
        license = (data as List)
            .map<LicenseTemplateEntity>((e) => LicenseTemplateEntity(
                  id: e['id'].toString(),
                  name: e['name'] as String,
                  mp3: bool.parse(e['mp3'].toString()),
                  wav: bool.parse(e['wav'].toString()),
                  zip: bool.parse(e['zip'].toString()),
                  price: 0,
                  description: e['description'] as String,
                  musicRecording: bool.parse(e['musicRecording'].toString()),
                  liveProfit: bool.parse(e['liveProfit'].toString()),
                  distributeCopies: int.parse(e['distributeCopies'].toString()),
                  audioStreams: int.parse(e['audioStreams'].toString()),
                  radioBroadcasting:
                      int.parse(e['radioBroadcasting'].toString()),
                  musicVideos: int.parse(e['musicVideos'].toString()),
                ))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 36.0,
      runSpacing: 20.0,
      children: List.generate(
        license.length,
        (index) {
          return LicenseChildWidget(license: license[index]);
        },
      ),
    );
  }
}

class LicenseChildWidget extends StatefulWidget {
  const LicenseChildWidget({super.key, required this.license});

  final LicenseTemplateEntity license;

  @override
  State<LicenseChildWidget> createState() => _LicenseChildWidgetState();
}

class _LicenseChildWidgetState extends State<LicenseChildWidget> {
  bool value = false;
  final TextEditingController _controller = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    List<String> availableFiles = [];

    if (widget.license.mp3) {
      availableFiles.add("MP3");
    }
    if (widget.license.wav) {
      availableFiles.add("WAV");
    }
    if (widget.license.zip) {
      availableFiles.add("TRACKOUT");
    }

    String availableFilesString = availableFiles.join(", ");

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: (MediaQuery.of(context).size.width - 200 - 178) / 2),
      child: Container(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: value
              ? const Color(0xff1E1E1E)
              : const Color(0xff1E1E1E).withOpacity(0.4),
          border: Border.all(
            color: value
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
                  widget.license.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: value ? Colors.white : Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    fontFamily: "OpenSans",
                  ),
                ),
                Text(
                  availableFilesString,
                  style: TextStyle(
                    fontSize: 12,
                    color: value
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
                  visible: value,
                  child: SizedBox(
                    width: 75,
                    height: 45,
                    child: TextFormField(
                      enabled: value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                      ],
                      controller: _controller,
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
                            color: Colors.white.withOpacity(0.05),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.2),
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
                        fontSize: 16,
                        height: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          widget.license.price = int.parse(value.toString());
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Switch(
                  trackColor: WidgetStateProperty.resolveWith(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color(0xff8D40FF);
                      }
                      return const Color(0xffE6E0E9);
                    },
                  ),
                  thumbColor: WidgetStateProperty.resolveWith(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return HSLColor.fromColor(Colors.white).toColor();
                      }
                      return const Color(0xff79747E);
                    },
                  ),
                  splashRadius: 24,
                  value: widget.license.isActive,
                  onChanged: (bool newValue) {
                    setState(() {
                      if (newValue) {
                        _controller.text = "0";
                      }
                      widget.license.isActive = newValue;
                      value = widget.license.isActive;

                      widget.license.price = 0;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LicenseTemplateEntity extends LicenseEntity {
  int price = 0;
  bool isActive = false;

  LicenseTemplateEntity({
    required super.id,
    required super.name,
    required super.mp3,
    required super.wav,
    required super.zip,
    required this.price,
    required super.description,
    required super.musicRecording,
    required super.liveProfit,
    required super.distributeCopies,
    required super.audioStreams,
    required super.radioBroadcasting,
    required super.musicVideos,
  });
}
