import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibeat_web/core/usercases/usecase.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/allLicenses/domain/usecases/get_all_licenses.dart';
import 'package:vibeat_web/features/allLicenses/domain/usecases/make_empty_license.dart';

part 'all_licenses_event.dart';
part 'all_licenses_state.dart';

class AllLicensesBloc extends Bloc<AllLicensesEvent, AllLicensesState> {
  final GetAllLicenses getAllLicenses;
  final MakeEmptyLicense makeEmptyLicense;

  AllLicensesBloc({
    required this.getAllLicenses,
    required this.makeEmptyLicense,
  }) : super(const AllLicensesState()) {
    on<AllLicensesEvent>(_onGetLicenses);
    on<MakeEmptyLicenseEvent>(_onMakeEmptyBeat);
    on<ResetMakeEmptyLicenseSuccessEvent>(_onResetMakeEmptyLicenseSuccess);
  }

  Future<void> _onGetLicenses(
      AllLicensesEvent event, Emitter<AllLicensesState> emit) async {
    final result = await getAllLicenses(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        status: AllLicenseStatus.error,
        errorMessage: failure.message,
      )),
      (licenses) => emit(state.copyWith(
        status: AllLicenseStatus.success,
        licenses: licenses,
      )),
    );
  }

  Future<void> _onMakeEmptyBeat(
      MakeEmptyLicenseEvent event, Emitter<AllLicensesState> emit) async {
    final result = await makeEmptyLicense(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        status: AllLicenseStatus.error,
        errorMessage: failure.message,
      )),
      (result) => emit(state.copyWith(
        status: AllLicenseStatus.success,
        makeEmptyLicenseSuccess: true,
        newLicense: result,
      )),
    );
  }

  void _onResetMakeEmptyLicenseSuccess(
      ResetMakeEmptyLicenseSuccessEvent event, Emitter<AllLicensesState> emit) {
    emit(state.copyWith(
      makeEmptyLicenseSuccess: false,
      newLicense: null,
    ));
  }
}
