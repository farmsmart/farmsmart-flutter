import 'TransactionAmount.dart';

class TransactionEntity {
    final String uri;
    final TransactionAmount amount;
    final String tag;
    final String description;
    final DateTime timestamp;

  TransactionEntity(this.uri, this.amount, this.tag, this.description, this.timestamp);

}