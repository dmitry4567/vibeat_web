import 'package:flutter/material.dart';

class ConditionsWidget extends StatefulWidget {
  ConditionsWidget({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  bool value;
  final Function(bool) onChanged;

  @override
  State<ConditionsWidget> createState() => _ConditionsWidgetState();
}

class _ConditionsWidgetState extends State<ConditionsWidget> {
  int price = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: widget.value
            ? const Color(0xff1E1E1E)
            : const Color(0xff1E1E1E).withOpacity(0.4),
        border: Border.all(
          color: widget.value
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
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.value
                      ? Colors.white
                      : Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontFamily: "Helvetica",
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 12,
                  color: widget.value
                      ? Colors.white.withOpacity(0.6)
                      : Colors.white.withOpacity(0.4),
                  fontWeight: FontWeight.w500,
                  fontFamily: "Helvetica",
                  height: 1.5,
                ),
              ),
            ],
          ),
          Row(
            children: [
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
                // thumbIcon: WidgetStateProperty.resolveWith(
                //   (Set<WidgetState> states) {
                //     if (states.contains(WidgetState.selected)) {
                //       return const Icon(Icons.check,
                //           color: Colors.green);
                //     }
                //     return null;
                //   },
                // ),
                value: widget.value,
                onChanged: (bool newValue) {
                  widget.onChanged(newValue); // Вызываем callback
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
