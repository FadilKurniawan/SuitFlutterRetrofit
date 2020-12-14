import 'package:equatable/equatable.dart';

abstract class ServiceEvent extends Equatable {}

class ServiceLoadListEvent extends ServiceEvent {
  @override
  List<Object> get props => null;
}

class ServiceLoadDetailEvent extends ServiceEvent {
  @override
  List<Object> get props => null;
}

class ServiceRefreshListEvent extends ServiceEvent {
  final int perPage;
  final int page;

  ServiceRefreshListEvent({this.perPage = 10, this.page = 1});

  @override
  List<Object> get props => [perPage, page];
}

class ServiceRefreshNextListEvent extends ServiceEvent {
  @override
  List<Object> get props => null;
}

class ServiceRefreshDetailEvent extends ServiceEvent {
  final int id;

  ServiceRefreshDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ServicePostEvent extends ServiceEvent {
  final Map<String, Object> parameters;

  ServicePostEvent({this.parameters});

  @override
  List<Object> get props => null;
}

class ServiceShimmerEvent extends ServiceEvent {
  @override
  List<Object> get props => [];
}