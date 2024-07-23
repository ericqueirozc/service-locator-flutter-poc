class ServiceLocator {
  static Map<Type, dynamic> singletonServices = {};
  static Map<Type, dynamic> lazySingletonServices = {};
  static Map<Type, dynamic> factoryServices = {};

  static T get<T extends Object>() {
    if (singletonServices.containsKey(T)) {
      return singletonServices[T];
    }

    if (factoryServices.containsKey(T)) {
      return factoryServices[T]();
    }

    if (lazySingletonServices.containsKey(T)) {
      singletonServices[T] = lazySingletonServices[T]();
      lazySingletonServices.remove(T);
      return singletonServices[T];
    }
    throw Exception('Service not found');
  }

  static registerSingleton<T extends Object>(T Function() instance) {
    _verifyInstances(instance);
    if (singletonServices[T] != null) return;
    singletonServices[T] = instance();
  }

  static registerLazySingleton<T extends Object>(T Function() instance) {
    _verifyInstances(instance);
    if (lazySingletonServices[T] != null) return;
    lazySingletonServices[T] = instance;
  }

  static registerFactory<T extends Object>(T Function() instance) {
    _verifyInstances(instance);
    if (factoryServices[T] != null) return;
    factoryServices[T] = instance;
  }

  static void _verifyInstances<T>(T instance) {
    if (singletonServices.containsKey(T)) {
      throw Exception('$T is already defined as singleton');
    }
    if (lazySingletonServices.containsKey(T)) {
      throw Exception('$T is already defined as lazySingleton');
    }
    if (factoryServices.containsKey(T)) {
      throw Exception('$T is already defined as factory');
    }
  }
}
