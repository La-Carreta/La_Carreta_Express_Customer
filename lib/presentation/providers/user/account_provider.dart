import 'package:flutter_riverpod/flutter_riverpod.dart';

final isEditingNameProvider = StateProvider<bool>((ref) => true);
final isEditingLastnameProvider = StateProvider<bool>((ref) => true);
final isEditingAddressProvider = StateProvider<bool>((ref) => true);
final isEditingPhoneNumberProvider = StateProvider<bool>((ref) => true);
final isEditingPasswordProvider = StateProvider<bool>((ref) => true);