part of 'edit_license_template_bloc.dart';

sealed class LicenseTemplateState extends Equatable {
  @override
  List<Object> get props => [];
}

final class EditLicenseTemplateState extends LicenseTemplateState {
  final LicenseEntity templateLicense;
  final bool isSavedSuccess;

  EditLicenseTemplateState({
    required this.templateLicense,
    required this.isSavedSuccess,
  });

  EditLicenseTemplateState copyWith({
    LicenseEntity? templateLicense,
    bool? isSavedSuccess,
  }) {
    return EditLicenseTemplateState(
      templateLicense: templateLicense ?? this.templateLicense,
      isSavedSuccess: isSavedSuccess ?? this.isSavedSuccess,
    );
  }

  @override
  List<Object> get props => [
        templateLicense,
        isSavedSuccess,
      ];
}
