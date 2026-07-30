import 'package:yuri_sale/features/quote/domain/entity/submit_rfq_data.dart';

abstract class QuoteEvent {}

class SubmitRfqEvent extends QuoteEvent {
  final SubmitRfqData data;

  SubmitRfqEvent(this.data);
}

class ResetQuoteEvent extends QuoteEvent {}
