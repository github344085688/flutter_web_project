import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class MyEvent {
  int index;
  MyEvent(this.index);
}

class RefreshWeb {
  bool isRefreshWeb;
  RefreshWeb(this.isRefreshWeb);
}

class RefreshWebFinished {
  bool isFinished;
  RefreshWebFinished(this.isFinished);
}