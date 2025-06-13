part of 'all_licenses_bloc.dart';

enum AllLicenseStatus { initial, loading, success, error }

class AllLicensesState extends Equatable {
  final AllLicenseStatus? status;
  final List<LicenseEntity>? licenses;
  final bool? makeEmptyLicenseSuccess;
  // final bool? deleteBeatSuccess;
  final String? errorMessage;
  final LicenseEntity? newLicense;

  const AllLicensesState({
    this.status,
    this.licenses,
    this.makeEmptyLicenseSuccess,
    // this.deleteBeatSuccess,
    this.errorMessage,
    this.newLicense,
  });

  AllLicensesState copyWith({
    AllLicenseStatus? status,
    List<LicenseEntity>? licenses,
    bool? makeEmptyLicenseSuccess,
    bool? deleteBeatSuccess,
    String? errorMessage,
    LicenseEntity? newLicense,
  }) {
    return AllLicensesState(
      status: status ?? this.status,
      licenses: licenses ?? this.licenses,
      makeEmptyLicenseSuccess: makeEmptyLicenseSuccess ?? this.makeEmptyLicenseSuccess,
      // deleteBeatSuccess: deleteBeatSuccess ?? this.deleteBeatSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      newLicense: newLicense ?? this.newLicense,
    );
  }

  @override
  List<Object?> get props => [
        status,
        licenses,
        makeEmptyLicenseSuccess,
        // deleteBeatSuccess,
        errorMessage,
        newLicense,
      ];
}
