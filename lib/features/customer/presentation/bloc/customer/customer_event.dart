abstract class CustomerEvent {}

class FetchCustomerEvent extends CustomerEvent {
  final String query;

  FetchCustomerEvent(this.query);

  List<Object?> get props => [query];
}
