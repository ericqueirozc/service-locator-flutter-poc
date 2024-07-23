class ServiceLocator {
  static Map<Type, dynamic> singletonServices = {};
  static Map<Type, dynamic> lazySingletonServices = {};
  static Map<Type, dynamic> factoryServices = {};

  static T get<T>() {
    if (singletonServices.containsKey(T)) {
      return singletonServices[T];
    }

    if (factoryServices.containsKey(T)) {
      return singletonServices[T]();
    }

    if (lazySingletonServices.containsKey(T)) {
      singletonServices[T] = lazySingletonServices[T]();
      singletonServices.remove(T);
      return singletonServices[T];
    }

    throw Exception('Service not found');
  }

  static registerSingleton<T extends Object>(T instance) {
    if (singletonServices[T] == null) {
      singletonServices[T] = instance;
    }
  }

  static registerLazySingleton<T extends Object>(T instance) {
    if (lazySingletonServices[T] == null) {
      lazySingletonServices[T] = instance;
    }
  }

  static registerFactory<T extends Object>(T instance) {
    if (factoryServices[T] == null) {
      factoryServices[T] = instance;
    }
  }
}
