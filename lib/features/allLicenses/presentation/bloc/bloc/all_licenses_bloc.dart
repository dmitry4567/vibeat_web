import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibeat_web/core/usercases/usecase.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/allLicenses/domain/usecases/get_all_licenses.dart';

part 'all_licenses_event.dart';
part 'all_licenses_state.dart';

class AllLicensesBloc extends Bloc<AllLicensesEvent, AllLicensesState> {
  final GetAllLicenses getAllLicenses;

  AllLicensesBloc({
    required this.getAllLicenses,
  }) : super(const AllLicensesState()) {
    on<AllLicensesEvent>(_onGetLicenses);
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
}
