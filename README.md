# J'Donuts

A donut-shop loyalty app built for the Madivizion senior Flutter code test: fake phone sign-up with real validation, an offline-first Home and Product detail, and an animated Rewards screen.

> **Status:** project setup is complete (architecture, design tokens, motion, localization, local database, navigation, CI). The three tasks are in progress; sections marked *(Task N)* are filled in as each task lands.

## Contents

- [How to run](#how-to-run)
- [Versions](#versions)
- [Architecture](#architecture)
- [Folder map](#folder-map)
- [State management](#state-management)
- [Offline strategy](#offline-strategy)
- [Animations](#animations)
- [Fake OTP](#fake-otp)
- [Testing and CI](#testing-and-ci)
- [Known gaps](#known-gaps)
- [Time spent](#time-spent)

## How to run

Prerequisites: Flutter 3.47.9 (stable), Xcode for iOS, Android Studio or the Android SDK for Android.

```bash
flutter pub get
flutter run                     # pick an iOS Simulator, Android emulator or a connected phone
```

Generated code (freezed, json_serializable, injectable, Drift, flutter_gen, gen-l10n) is committed, so the app runs straight after `flutter pub get`. After changing annotated code, ARB files or Drift tables, regenerate:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

Builds:

```bash
flutter build apk --release                 # build/app/outputs/flutter-apk/app-release.apk
flutter build ios --simulator               # zip build/ios/iphonesimulator/Runner.app
```

The app follows the phone's language: Burmese on a Burmese phone, English otherwise.

## Versions

| Tool | Version |
|---|---|
| Flutter | 3.47.9 (stable) |
| Dart | 3.13.7 |
| Android | Gradle 9.3.1, Android Gradle Plugin 9.1.0, Java 17 target |
| iOS | deployment target 15.0 |

## Architecture

Clean architecture, feature-first. Each feature has three layers:

| Layer | Holds | Depends on |
|---|---|---|
| `presentation` | pages, widgets, cubits | `domain` |
| `domain` | entities, repository interfaces, use cases, validators (no Flutter imports) | nothing |
| `data` | Drift tables and DAOs, models, repository implementations | `domain` |

- **Results, not exceptions.** Data sources throw; repositories map errors to typed `AppException`s; use cases return `DataState<T>` (`Success` or `Failed(Failure)`). Widgets map each `Failure` to localized text.
- **Dependency injection** with get_it + injectable. No widget creates a service.
- **Navigation** with go_router: one router, an auth redirect guard (every route needs a session unless it is public), and `/product/:id` as a path parameter. The selected tab is part of the location (`/?tab=rewards`).
- **Design tokens** for colour, type, spacing, radius, shadow and motion live in `shared/styles`; widgets never hard-code colours, strings or sizes.
- **Localization** with gen-l10n ARB files in English and Burmese.

## Folder map

```
lib/
  main.dart · app.dart          startup: DI, session check before the first frame, MaterialApp.router
  config/                       app constants (database file name, …)
  core/                         DataState, exceptions, failures, use case base classes,
                                network check, logging, Drift database + migrations
  di/                           injector and third-party modules
  navigation/                   router, auth redirect, tab shell, typed navigation helpers
  shared/
    components/                 error/empty view, skeleton shimmer, snack bar, focus wrapper
    extensions/                 BuildContext, SizedBox and system overlay helpers
    styles/                     theme, colour, type, spacing and motion tokens
  l10n/                         app_en.arb, app_my.arb (+ generated code)
  features/
    auth/                       session, sign-up and log-in flow, validators
    member/                     the single member record shared by Home and Rewards
    home/                       banners, sections, nearby shops
    product/                    products and product detail
    rewards/                    tiers and challenges
    settings/                   settings (log out) and placeholder tabs
drift_schemas/                  committed schema snapshot per database version
test/                           mirrors lib/
```

## State management

**Cubit** (flutter_bloc) with **get_it + injectable**.

- Cubits keep each screen's logic out of widgets and are easy to unit-test with `bloc_test`.
- States are immutable freezed `sealed` classes, so the UI handles every state with an exhaustive `switch`.
- One app-wide `AuthenticationCubit` drives the router's redirect; screen cubits are created per route.
- Streams from the local database are exposed through stream use cases; cubits cancel their subscriptions in `close()`.

## Offline strategy

- **Drift (SQLite)** is the single source of truth: the UI only ever reads the local database.
- **Versioned migrations** with Drift's `make-migrations` workflow. Each schema version has a committed snapshot in `drift_schemas/`, and a test fails if a table changes without a version bump.
- Database errors become `CacheFailure`s with a clear message instead of crashes.
- The session is kept in `flutter_secure_storage`; non-secret flags live in an `app_meta` table.
- *(Task 2)* Seeding from bundled JSON on first launch, background refresh when the network returns, the offline banner, and disk-cached images with bundled seed images.

## Animations

All durations and curves are named constants in one motion file (`shared/styles/app_motion.dart`). With Reduce Motion on (`MediaQuery.disableAnimations`), animations are skipped or shortened.

Built so far:

- Skeleton shimmer for loading states (stops under Reduce Motion).
- Snack bars that slide in from the top.

*(Tasks 1–3)* Onboarding entrance, registration step transitions and progress ring, input focus/error states and the OTP shake, button press and loading morph, Welcome tiles, Home sections and banner carousel, the product Hero transition and quantity counter, the bottom-nav pill, and the full Rewards screen.

## Fake OTP

Use **`123456`**. Any other code fails; three wrong codes lock entry until Resend.

## Testing and CI

```bash
flutter analyze
flutter test
```

Tests mirror `lib/` and describe behaviour (for example `sends a signed-out user from any guarded route to onboarding`). They cover the core result types, database and migrations, components, navigation and the app startup.

*(Task 2)* The integration test Register → Home → Product detail runs on a simulator or emulator with `flutter test integration_test`.

GitHub Actions (`.github/workflows/ci.yml`) runs on every push and pull request to `master`:

1. regenerates code and localizations and fails if anything differs from what is committed;
2. checks formatting, runs `flutter analyze` and `flutter test`;
3. builds a release APK and attaches it to the run as a downloadable artifact.

## Known gaps

- The three tasks are in progress (see the status note at the top).
- The bottom-nav bar is a plain Material `NavigationBar` until the Home design is built; the third tab's name (`orders`) is inferred from the design icon.
- Release APKs are signed with the debug key, which is fine for installing on test phones but not for store release.

## Time spent

| Area | Time |
|---|---|
| Project setup | — |
| Task 1 — Auth | — |
| Task 2 — Home and Product (offline) | — |
| Task 3 — Rewards | — |
| Motion polish, tests, README | — |
