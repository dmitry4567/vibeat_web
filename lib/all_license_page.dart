import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vibeat_web/app/app_router.dart';
import 'package:vibeat_web/responsive.dart';

@RoutePage()
class AllLicensePage extends StatefulWidget {
  const AllLicensePage({super.key});

  @override
  State<AllLicensePage> createState() => _AllLicensePageState();
}

class CategoryType {
  final int index;
  final Color color;
  final String value;

  CategoryType({required this.index, required this.color, required this.value});
}

class _AllLicensePageState extends State<AllLicensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0C0C0C),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  "Студия / Лицензии",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Helvetica",
                  ),
                ),
                const Text(
                  "Лицензии",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Helvetica",
                  ),
                ),
                const SizedBox(height: 12),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.licenseCrossAxisCount(
                  MediaQuery.of(context).size.width,
                ),
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: Responsive.licenseChildAspectRatio(
                  MediaQuery.of(context).size.width,
                ),
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xff1C1C1C),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "MP3 Leasing",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Mp3 Tagged, MP3, WAV".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Helvetica",
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                context.router.push(const EditLicenseRoute());
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Color(0xff5F6368),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Divider(
                          color: Colors.white.withOpacity(0.25),
                          thickness: 1,
                        ),
                        const SizedBox(height: 24),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LicenseData(
                                  icon: Icons.mic_none_outlined,
                                  title: "Используется для записи\nмузыки",
                                ),
                                SizedBox(height: 32),
                                LicenseData(
                                  icon: Icons.copy,
                                  title: "Безлимитное\nраспространение",
                                ),
                                SizedBox(height: 32),
                                LicenseData(
                                  icon: Icons.video_camera_back,
                                  title:
                                      "Безлимитное выпуск\nмузыкальных видео",
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LicenseData(
                                  icon: Icons.mic_none_outlined,
                                  title: "Используется для записи\nмузыки",
                                ),
                                SizedBox(height: 32),
                                LicenseData(
                                  icon: Icons.copy,
                                  title: "Безлимитно\nраспространение",
                                ),
                                SizedBox(height: 32),
                                LicenseData(
                                  icon: Icons.video_camera_back,
                                  title:
                                      "Безлимитное выпуск\nмузыкальных видео",
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                childCount: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LicenseData extends StatelessWidget {
  const LicenseData({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 36,
          color: Colors.white.withOpacity(0.5),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
