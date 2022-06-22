import 'package:intl/intl.dart';

extension NumberExtension on num {
  String formatCurrency() {
    return NumberFormat(r'R$ ###,##0.00', 'pt-BR').format(this);
  }
}
