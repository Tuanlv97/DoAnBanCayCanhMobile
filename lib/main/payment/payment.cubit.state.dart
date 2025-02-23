// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_bill/service_bill.dart';
import 'package:service_plant/service_plant.dart';
import 'package:service_user/service_user.dart';

class PaymentCubitState extends Equatable {
  final PaymentStatus status;
  BillModel billModel;
  PaymentCubitState({
    required this.status,
    required this.billModel,
  });

  PaymentCubitState copyWith({
    PaymentStatus? status,
    BillModel? billModel,
  }) {
    return PaymentCubitState(
      status: status ?? this.status,
      billModel: billModel ?? this.billModel,
    );
  }

  @override
  List<Object> get props => [status, billModel];
}

enum PaymentStatus { initial, loading, success, error }
