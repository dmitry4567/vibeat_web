import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vibeat_web/widgets/conditions_widget.dart';

@RoutePage()
class EditLicensePage extends StatefulWidget {
  const EditLicensePage({super.key});

  @override
  State<EditLicensePage> createState() => _EditLicensePageState();
}

class _EditLicensePageState extends State<EditLicensePage> {
  bool highlighted1 = false;
  bool _checkbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0C0C0C),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const Text(
              "Студия / Лицензии / Редактирование лицензии",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "Helvetica",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Редактирование лицензии",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Helvetica",
                  ),
                ),
                Row(
                  children: [
                    MaterialButton(
                      height: 44,
                      onPressed: () {
                        context.router.popForced();
                      },
                      color: const Color(0xff1E1E1E),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Удалить",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    MaterialButton(
                      height: 44,
                      onPressed: () {
                        context.router.popForced();
                      },
                      color: const Color(0xff8D40FF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Сохранить",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Visibility(
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
                          TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: TextEditingController(),
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
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.top,
                              controller: TextEditingController(),
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
                                        value: _checkbox,
                                        onChanged: (value) {
                                          setState(
                                            () => _checkbox = !_checkbox,
                                          );
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
                                        value: _checkbox,
                                        onChanged: (value) {
                                          setState(
                                            () => _checkbox = !_checkbox,
                                          );
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
                                        value: _checkbox,
                                        onChanged: (value) {
                                          setState(
                                            () => _checkbox = !_checkbox,
                                          );
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
            ),
            Visibility(
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
                    const Row(
                      children: [
                        Expanded(
                          child: ConditionsWidget(
                            title: "Запись музыки",
                            description:
                                "Укажите, разрешавете ли вы запись музыки при\nналичии данной лицензии",
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: ConditionsWidget(
                            title: "Коммерческие выступления",
                            description:
                                "Укажите, разрешаете ли вы коммерческие выступления при\nналичии данной лицензии",
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
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlignVertical: TextAlignVertical.center,
                                controller: TextEditingController(),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Checkbox(
                                        value: _checkbox,
                                        onChanged: (value) {
                                          setState(
                                            () => _checkbox = !_checkbox,
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
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlignVertical: TextAlignVertical.center,
                                controller: TextEditingController(),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Checkbox(
                                        value: _checkbox,
                                        onChanged: (value) {
                                          setState(
                                            () => _checkbox = !_checkbox,
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
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlignVertical: TextAlignVertical.center,
                                controller: TextEditingController(),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Checkbox(
                                        value: _checkbox,
                                        onChanged: (value) {
                                          setState(
                                            () => _checkbox = !_checkbox,
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
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlignVertical: TextAlignVertical.center,
                                controller: TextEditingController(),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Checkbox(
                                        value: _checkbox,
                                        onChanged: (value) {
                                          setState(
                                            () => _checkbox = !_checkbox,
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
            )
          ],
        ),
      ),
    );
  }
}
