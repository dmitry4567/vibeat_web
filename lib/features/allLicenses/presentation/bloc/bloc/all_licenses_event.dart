part of 'all_licenses_bloc.dart';

sealed class AllLicensesEvent extends Equatable {
  const AllLicensesEvent();

  @override
  List<Object> get props => [];
}

class GetAllLicensesEvent extends AllLicensesEvent {}
