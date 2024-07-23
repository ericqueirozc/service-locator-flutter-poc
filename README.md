# Service Locator

Este é um estudo sobre o padrão Service Locator utilizando Flutter.

O padrão Service Locator serve como um ponto central para a obtenção de instâncias (ou dependências) em uma aplicação. Ele tem o papel de armazenar, criar e buscar as instâncias conforme solicitado pelo cliente.

Este padrão é frequentemente comparado com o padrão de Injeção de Dependência, pois ambos têm o objetivo de fornecer dependências aos clientes.

```dart
class ServiceLocator {

  static Map<Type, dynamic> services = {};

  static T get<T>() {
    return services[T];
  }

  static void register<T extends Object>(T instance) {
    services[T] = instance;
  }
}
```

```dart
void main() {
  ServiceLocator.register<LoginStore>(LoginStore());
  runApp(const MyApp());
}
```

```dart
 @override
  void initState() {
    super.initState();
    _loginStore = ServiceLocator.get<LoginStore>();
  }
```

Às vezes, é necessário que as dependências sejam criadas de maneiras diferentes. É comum que as instâncias precisem ser criadas como [Singleton] ou [Factory], e por isso precisamos considerar como integrar esses padrões em nossa implementação. O Singleton é o caso mais simples, seguindo a lógica de que apenas uma instância da dependência pode existir.

A implementação é a seguinte:

```dart
  static registerSingleton<T extends Object>(T Function() instance) {
    _verifyInstances(instance);
    if (singletonServices[T] != null) return;
    singletonServices[T] = instance();
  }
```
Como agora vamos trabalhar com mais de um tipo de instância, é necessário criar um Map diferente para cada um, como o singletonServices acima.

Para melhorar a performance, também seria interessante criar a instância do singleton apenas quando ela for solicitada, resultando em um lazy singleton:

```dart
  static registerLazySingleton<T extends Object>(T Function() instance) {
    _verifyInstances(instance);
    if (lazySingletonServices[T] != null) return;
    lazySingletonServices[T] = instance;
  }
```

Note que a criação é muito semelhante à do Singleton, porém, neste caso, guardamos a função que cria a instância em vez da instância criada.

A "mágica" acontece ao recuperar a instância no nosso método get:

```dart
    if (lazySingletonServices.containsKey(T)) {
      singletonServices[T] = lazySingletonServices[T]();
      lazySingletonServices.remove(T);
      return singletonServices[T];
    }
```

A instância do Singleton é criada e, a partir desse momento, ela pertence ao Map dos Singleton. Na próxima vez que for recuperada, sua instância já existirá e não precisará ser criada novamente.

E se for necessário que uma nova instância seja criada sempre que uma dependência for recuperada? Nesse caso, temos o padrão Factory, que é implementado da seguinte maneira:

```dart
  static registerFactory<T extends Object>(T Function() instance) {
    _verifyInstances(instance);
    if (factoryServices[T] != null) return;
    factoryServices[T] = instance;
  }
```

O registro da dependência é igual ao do lazy Singleton. Ao recuperar a dependência, a instância é então criada:

```dart
    if (factoryServices.containsKey(T)) {
      return factoryServices[T]();
    }
```
