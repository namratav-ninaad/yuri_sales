abstract class CustomerEvent {}

class FetchCustomerEvent extends CustomerEvent {
  final String search;

  FetchCustomerEvent(this.search);

  List<Object?> get props => [search];
}
