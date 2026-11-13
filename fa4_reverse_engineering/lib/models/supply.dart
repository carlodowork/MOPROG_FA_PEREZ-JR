import 'parameter.dart';

class Supply {
  final String name;
  final int quantity;
  final double unitPrice;
  final Parameter parameter;

  const Supply({
    required this.name,
    required  this.quantity,
    required this.unitPrice,
    required this.parameter,
  });

  double get total => quantity * unitPrice;  
}
