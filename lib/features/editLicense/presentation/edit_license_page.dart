import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/app/injection_container.dart';
import 'package:vibeat_web/custom_functions.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/editLicense/presentation/bloc/edit_license_template_bloc.dart';
import 'package:vibeat_web/features/editLicense/presentation/widgets/basic_data_license.dart';
import 'package:vibeat_web/features/editLicense/presentation/widgets/distributing_data.dart';

@RoutePage()
class EditLicensePage extends StatefulWidget {
  const EditLicensePage({super.key, required this.templateLicense});

  final LicenseEntity templateLicense;

  @override
  State<EditLicensePage> createState() => _EditLicensePageState();
}

class _EditLicensePageState extends State<EditLicensePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditLicenseTemplateBloc>(
      create: (context) => sl<EditLicenseTemplateBloc>(
        param1: widget.templateLicense,
      ),
      child: BlocListener<EditLicenseTemplateBloc, LicenseTemplateState>(
        listener: (context, state) {
          if (state is EditLicenseTemplateState &&
              state.isSavedSuccess == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              setupSnackBar("License saved"),
            );
          }
        },
        child: Builder(
          builder: (context) => Scaffold(
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
                              // context.router.popForced();

                              context
                                  .read<EditLicenseTemplateBloc>()
                                  .add(const SaveDraftLicenseEvent());
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
                  const BasicDataLicense(),
                  const DistributingDataLicense(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
