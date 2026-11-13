# Шпаргалка к защите

Короткие ответы на вопросы преподавателя. Все пути — от корня проекта.

---

## 1. Что такое BLoC и зачем он нужен?

**Вопрос:** Что такое BLoC и зачем он нужен?

**Ответ:** BLoC — это отдельный класс, который хранит состояние экрана и обрабатывает события. Виджеты не лезут в API сами: они отправляют событие, BLoC вызывает репозиторий и отдаёт новое состояние. У нас три BLoC: `SearchBloc`, `ProfileBloc` и `MetaBloc` в папке `lib/presentation/bloc/`. Так логика не смешивается с интерфейсом, и один и тот же код проще тестировать.

---

## 2. Как работает Debounce при поиске?

**Вопрос:** Как работает Debounce при поиске?

**Ответ:** Когда пользователь печатает, каждый символ отправляет событие `SearchQueryChanged`. Debounce ждёт 500 мс: если за это время пришёл новый символ, старый запрос отменяется. Только после паузы уходит запрос в OpenDota. Код лежит в `lib/core/utils/debounce.dart`, задержка задана в `ApiConstants.searchDebounce`.

---

## 3. Как приложение получает данные из API? Где DTO и репозиторий?

**Вопрос:** Как приложение получает данные из API? Где DTO и репозиторий?

**Ответ:** Запросы делает `OpenDotaApi` в `lib/data/datasources/open_dota_api.dart` через библиотеку Dio. Ответ API превращается в DTO в папке `lib/data/dto/`, например `HeroDto` или `PlayerDto`. Дальше репозиторий (`lib/data/repositories/`) переводит DTO в сущности из `lib/domain/entities/` и отдаёт их BLoC. Интерфейсы репозиториев лежат отдельно в `lib/domain/repositories/`, поэтому UI не зависит от конкретного API.

---

## 4. Как сохраняются лайки через SharedPreferences?

**Вопрос:** Как сохраняются лайки через SharedPreferences?

**Ответ:** Лайкнутые игроки и герои хранятся в `SharedPreferences` под ключом `liked_items_v1` в виде JSON-списка. За это отвечает `LikesRepositoryImpl` в `lib/data/repositories/likes_repository_impl.dart`. Состоянием управляет `LikesCubit`: он добавляет или удаляет элемент и сразу сохраняет список на устройство. После перезапуска приложения лайки остаются.

---

## 5. Где показать Лабу 2 (классы, Future, extension)?

**Вопрос:** Где показать Лабу 2 (классы, Future, extension)?

**Ответ:** Открыть вкладку «Dart» внизу или нажать кнопку «Лаба 2: основы Dart» на экране поиска. Код лежит в `lib/presentation/screens/dart_basics_screen.dart`. Там есть класс `_DemoHero` с полями и методами, `enum _DemoRole`, циклы, generic-класс `_Team<T>`, анонимные функции, `Future` и `extension` с геттером `cardTitle`. Кнопка «Запустить пример» выполняет асинхронный код и показывает результат на экране.

---

## Дополнительно: что показать в коде

| Что проверяют | Файл |
|---|---|
| AppBar с ФИО и группой | `lib/presentation/screens/home_shell.dart` |
| Карточки и картинки | `lib/presentation/widgets/hero_card.dart` |
| Лайк и SnackBar | `lib/presentation/widgets/like_button.dart` |
| Переход на детали | `lib/presentation/screens/hero_detail_screen.dart` |
| Поиск и debounce | `lib/presentation/bloc/search/search_bloc.dart` |
| Обновление страницы | `RefreshIndicator` в `search_screen.dart`, `meta_screen.dart`, `player_profile_screen.dart` |
| Иконка приложения | `assets/icon/app_icon.png` |
| Локализация RU/EN | `lib/l10n/app_ru.arb`, `lib/l10n/app_en.arb` |
| Хранение лайков | `lib/data/repositories/likes_repository_impl.dart` |
