import 'TransactionAmount.dart';

class TransactionEntity {
    final String id;
    final TransactionAmount amount;
    final String tag;
    final String description;

  TransactionEntity(this.id, this.amount, this.tag, this.description);

}