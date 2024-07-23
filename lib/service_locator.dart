class ServiceLocator {

  static Map<Type, dynamic> services = {};

  static T get<T>() {
    return services[T];
  }

  static void register<T extends Object>(T instance) {
    services[T] = instance;
  }
}
