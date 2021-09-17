List<dynamic>? _services;
void registerServices({required List<dynamic> services}) {
  _services = services;
}

typedef ServiceCreator<T extends Service> = T Function();

class ServiceInjector<T extends Service> {
  final ServiceCreator<T> create;
  T? _value;
  T get value {
    _value ??= create();
    return _value!;
  }

  ServiceInjector({required this.create});
  factory ServiceInjector.value({required T value}) =>
      ServiceInjector(create: () => value);

  void dispose() {
    if (_value != null) {
      _value!.dispose();
    }
  }
}

abstract class Service {
  static T find<T extends Service>() {
    final services = _services ?? [];
    for (var injector in services) {
      if (injector is ServiceInjector<T>) {
        return injector.value;
      }
    }

    throw Exception('No service found for ${T.runtimeType}');
  }

  void dispose() {}
}
