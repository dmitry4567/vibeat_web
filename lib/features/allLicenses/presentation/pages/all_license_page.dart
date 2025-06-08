import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/app/app_router.dart';
import 'package:vibeat_web/custom_functions.dart';
import 'package:vibeat_web/features/allLicenses/presentation/bloc/bloc/all_licenses_bloc.dart';
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
  void initState() {
    super.initState();

    context.read<AllLicensesBloc>().add(GetAllLicensesEvent());
  }

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
            sliver: BlocConsumer<AllLicensesBloc, AllLicensesState>(
              listener: (context, state) {
                if (state.status == AllLicenseStatus.error &&
                    state.errorMessage != null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(setupSnackBar(state.errorMessage!));
                }
              },
              builder: (context, state) {
                if (state.status == AllLicenseStatus.success) {
                  return SliverGrid(
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
                      childCount: state.licenses!.length,
                      (context, index) {
                        List<String> availableFiles = [];

                        if (state.licenses![index].mp3) availableFiles.add("MP3");
                        if (state.licenses![index].wav) availableFiles.add("WAV");
                        if (state.licenses![index].zip) availableFiles.add("TRACKOUT");

                        String availableFilesString = availableFiles.join(", ");

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.licenses![index].name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "OpenSans",
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        availableFilesString,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Helvetica",
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context.router
                                          .push(const EditLicenseRoute());
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      LicenseData(
                                        icon: Icons.mic_none_outlined,
                                        title: state.licenses![index]
                                                    .musicRecording ==
                                                true
                                            ? "Запись треков\nРазрешена"
                                            : "Запись треков\nЗапрещена",
                                      ),
                                      const SizedBox(height: 32),
                                      LicenseData(
                                        icon: Icons.copy,
                                        title: state.licenses![index]
                                                    .audioStreams ==
                                                -1
                                            ? "Платные прослушивания\nБезлимитно"
                                            : "Платные прослушивания\n${state.licenses![index].audioStreams}",
                                      ),
                                      const SizedBox(height: 32),
                                      LicenseData(
                                        icon: Icons.video_camera_back_outlined,
                                        title: state.licenses![index]
                                                    .musicVideos ==
                                                -1
                                            ? "Музыкальное видео\nБезлимитно"
                                            : "Музыкальное видео\n${state.licenses![index].musicVideos}",
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      LicenseData(
                                        icon: Icons.music_note,
                                        title:
                                            state.licenses![index].liveProfit ==
                                                    true
                                                ? "Выступления\nРазрешено"
                                                : "Выступления\nЗапрещено",
                                      ),
                                      const SizedBox(height: 32),
                                      LicenseData(
                                        icon: Icons.library_music_outlined,
                                        title: state.licenses![index]
                                                    .distributeCopies ==
                                                -1
                                            ? "Выпуск копий\nБезлимитно"
                                            : "Выпуск копий\n${state.licenses![index].distributeCopies}",
                                      ),
                                      const SizedBox(height: 32),
                                      LicenseData(
                                        icon:
                                            Icons.radio_button_checked_rounded,
                                        title: state.licenses![index]
                                                    .radioBroadcasting ==
                                                -1
                                            ? "Радиостанции\nБезлимитно"
                                            : "Радиостанции\n${state.licenses![index].radioBroadcasting}",
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SliverToBoxAdapter();
              },
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
