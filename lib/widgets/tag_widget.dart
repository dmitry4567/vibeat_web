import 'package:flutter/material.dart';

class TagCard extends StatelessWidget {
  const TagCard(
      {super.key, required this.index, required this.value, this.delete});

  final int index;
  final String value;
  final Function? delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: index != 0 ? 8 : 0),
      padding: EdgeInsets.only(
        left: 11,
        right: delete != null ? 8 : 11,
        top: 7,
        bottom: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#$value',
            style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
          const SizedBox(
            width: 2,
          ),
          delete != null
              ? InkWell(
                  onTap: () {
                    print("dell");
                  },
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.close,
                      color: Colors.white.withOpacity(0.3),
                      size: 16,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
