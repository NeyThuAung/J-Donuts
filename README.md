# J'Donuts

A donut-shop loyalty app built for the Madivizion senior Flutter code test: phone sign-up and log-in with real validation and a fake OTP, an offline-first Home and Product detail, and an animated Rewards screen. English and Burmese.

## Contents

- [How to run](#how-to-run)
- [Versions](#versions)
- [Architecture](#architecture)
- [Folder map](#folder-map)
- [State management](#state-management)
- [Offline strategy](#offline-strategy)
- [Mock server](#mock-server)
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

Generated code (freezed, json_serializable, injectable, retrofit, Drift, flutter_gen, gen-l10n) is committed, so the app runs straight after `flutter pub get`. After changing annotated code, ARB files or Drift tables, regenerate:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

Builds:

```bash
flutter build apk --release     # build/app/outputs/flutter-apk/app-release.apk
flutter build ios --simulator   # then zip the app for the iOS Simulator:
cd build/ios/iphonesimulator && zip -r J-Donuts-simulator.zip Runner.app
```

To install the simulator build, unzip it and drag `Runner.app` onto a running simulator (or `xcrun simctl install booted Runner.app`).

The app follows the phone's language: Burmese on a Burmese phone, English otherwise. Portrait only, phones from 4.7" to 6.9", text scale up to 1.3.

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
| `data` | data sources (Drift, REST, secure storage), models, repository implementations | `domain` |

- **Results, not exceptions.** Data sources throw; repositories turn errors into typed `AppException`s (`runLocal`, `runRemote`); use cases return `DataState<T>` (`Success` or `Failed(Failure)`). Cubits hold typed failures and validation enums; widgets map them to localized text.
- **Dependency injection** with get_it + injectable. No widget creates a service; every page gets its cubit from its route.
- **Navigation** with go_router: one router, an auth redirect guard (every route needs a session unless it is public), a tab shell whose selected tab is part of the location (`/?tab=rewards`), and product detail as a path parameter (`/product/:id`).
- **Features talk through `domain` only.** Home and Rewards read the one member record through the member feature's use cases; Home reads products through the product feature's.
- **Design tokens** for colour, type, spacing, radius, shadow and motion live in `shared/styles`, in one theme (`AppThemeColors` is a `ThemeExtension`, dark-ready). Widgets never hard-code colours, strings or sizes.
- **Localization** with gen-l10n ARB files in English and Burmese, with bundled Figtree and Noto Sans Myanmar fonts.

## Folder map

```
lib/
  main.dart · app.dart          startup: DI, seed, session check before the first frame, MaterialApp.router
  config/                       API, database and storage constants
  core/
    data_state/ exceptions/ failures/ usecase/    result types and the use case base classes
    database/                   Drift database, tables, DAOs, migrations
    network/                    API envelope, Dio error mapping, connectivity + reachability check
    sync/                       seed reader, saveIfNewer, combineLatest
    image/                      bundled-or-network image references
  di/                           injector and third-party modules (Dio, Drift, secure storage, logger)
  navigation/                   router, auth redirect, tab shell, typed navigation helpers
  shared/
    components/                 buttons, fields, images, skeletons, error/empty views, sections,
                                motion helpers, snack bar, sheets, dialogs, bottom nav
    extensions/                 BuildContext, numbers, dates, SizedBox, system overlay helpers
    styles/                     theme, colour, type, spacing and motion tokens
    resources/                  R.images / R.icons (flutter_gen)
  l10n/                         app_en.arb, app_my.arb (+ generated code)
  features/
    auth/                       session, users, OTP, validators; onboarding to welcome pages
    member/                     the single member record shared by Home and Rewards
    home/                       banners, sections, nearby shops, seed and refresh, Home page
    product/                    products and the product detail page
    rewards/                    tiers, challenges and the Rewards page
    settings/                   settings (log out) and placeholder tabs
assets/seed/v1/                 bundled data, also published as the mock API
assets/images/ assets/fonts/    bundled seed images and fonts
drift_schemas/                  committed schema snapshot per database version
test/                           mirrors lib/
```

## State management

**Cubit** (flutter_bloc) with **get_it + injectable**.

- Cubits keep each screen's logic out of widgets and are easy to test with `bloc_test`.
- States are immutable freezed classes; the UI handles every state with an exhaustive `switch`.
- One app-wide `AuthenticationCubit` drives the router's redirect; screen cubits are created per route.
- Screens with several parts (Home, Rewards) keep a loading / ready / failed state per section, so one failing section never blanks the page.
- Cubits follow the local database through stream use cases and cancel their subscriptions in `close()`.

## Offline strategy

The local database is the single source of truth: **the UI only ever reads Drift (SQLite)**. The network only ever writes to it.

1. **First launch, even in airplane mode.** Before the first frame, the app seeds the database from bundled JSON (`assets/seed/v1`). Seed images are bundled too, so Home, Product detail and Rewards are complete with no network at all.
2. **Versioned data.** Every payload carries `meta.version`; a version is stored per table in an `app_meta` table. `saveIfNewer` writes only newer data, so a refresh never goes backwards and a bundled seed never overwrites a newer refresh.
3. **Refresh.** When the app starts online, or the connection comes back, it refreshes in the background; Home and Rewards also refresh on pull-to-refresh. The screens update through their database streams. A failed refresh keeps what is shown and only shows a snack (pull-to-refresh) or logs (background).
4. **Connectivity.** `connectivity_plus` plus a real reachability check (a DNS lookup), so Wi-Fi without internet counts as offline. An offline banner slides in while offline.
5. **Images.** A URL whose file is bundled loads from assets; anything else goes through `cached_network_image` with a disk cache, a shimmer placeholder and an error state.
6. **Auth is local too.** Users and the session live on the device (users in Drift, the session in `flutter_secure_storage`), so registering, logging out and logging back in all work offline.
7. **Schema changes** use Drift's `make-migrations` workflow: one committed snapshot per version in `drift_schemas/` and migration tests from every older version.

## Mock server

A static JSON API on GitHub Pages: `https://neythuaung.github.io/J-Donuts/v1/` (`member.json`, `products.json`, `banners.json`, `sections.json`, `shops.json`, `tiers.json`, `challenges.json`), with the images at `https://neythuaung.github.io/J-Donuts/images/`.

- **Source:** the same files as the bundled seed, `assets/seed/v1/`. The `Mock API` workflow (`.github/workflows/pages.yml`) checks that every file parses and publishes them on each push to `master`, so the app and the API can never disagree on shape.
- **Shape:** every response is `{ "data": …, "error": null, "meta": { "version": 1 } }`, the same envelope the app parses for the seed.
- **Client:** Dio + retrofit with connect and receive timeouts, retry with back-off on connection errors, timeouts and 5xx/429 (`dio_smart_retry`), and request logging in debug builds.
- **To change data:** edit a file in `assets/seed/v1/`, raise its `meta.version`, push. Running apps pick it up on their next refresh; new installs get it from the bundle.

## Animations

All durations, curves and intervals are named constants in one motion file (`shared/styles/app_motion.dart`). Built with Flutter's own animation APIs, no Lottie or Rive.

| Where | What it does |
|---|---|
| Onboarding | Six donut circles drift in from the edges one after another; title, Get started, log-in prompt and social row follow in a stagger. |
| Registration steps | Shared-axis transition on Android, the native slide (with swipe back) on iOS. The progress ring sweeps 25% → 50% → 75% → 100% from the previous step and then morphs into a check. |
| Inputs | The field border fades to cyan with a soft shadow on focus; error messages ease open. The OTP boxes shake and clear on a wrong code. |
| Buttons | Every tappable scales down on press. Continue morphs into a loading state, and taps are ignored while it loads. |
| Welcome | Donut tiles slide in one after another, then the title and button fade up. |
| Home | Skeleton shimmer while loading; header, sections and shops enter in a stagger; the banner carousel auto-plays (and pauses while the tab is hidden); the offline banner slides in. |
| Product tile → detail | Hero transition on the product image, with rounded corners kept through the flight. The card content fades up in order, the quantity rolls on change, the total counts to its new value, and Add to cart turns into "Added" with a check. |
| Tab switch | The bottom-nav pill slides between tabs with a small bounce and its label grows from the centre. |
| Rewards | The points ring (`CustomPainter`, glazed pink with sprinkles) sweeps while the total counts up to 680,000; the reward badge pops in; the tier shields (Silver → Gold → Platinum) appear in order, the current one highlighted, and the line to the next tier fills. The tab indicator slides between "Eat more earn more" and "Gift" and the list fades between them. Challenge cards enter in a stagger and draw their progress: the donut colours in by quarters, the coffee arc fills to 9/12. A complete challenge's Earn button breathes for attention. The entrance replays on every visit. |

**Reduce Motion** (`MediaQuery.disableAnimations`): entrances start finished, the shimmer holds still, page transitions and the Hero flight are off, the carousel stops auto-playing, the OTP shake and the Earn pulse are skipped, and sizes change at once. Every state change is still shown.

## Fake OTP

Use **`123456`**. Any other code fails and tells you how many tries are left; three wrong codes lock entry until **Resend**, which opens after a 5:00 countdown (or at once when locked).

Sign-up: Phone → OTP → Name → Date of birth → Welcome → Home. Log in: Phone → OTP → Home. Logging in with a new number, or registering a known one, shows an inline message with a link to the other flow.

## Testing and CI

```bash
flutter analyze
flutter test
```

412 tests mirror `lib/` and describe behaviour (for example `reports no connection in airplane mode and keeps local data`):

- **Validators and use cases:** every phone, OTP, name and date-of-birth rule; auth, seed and refresh use cases; tier and challenge progress.
- **Login and registration validation (widget tests):** each auth page is pumped with its real cubit and checked for the error the user sees and whether Continue is enabled.
- **Offline data:** the real Drift database in memory with the real repositories and the bundled seed; only the API is faked. Covers first launch without network, newer vs older versions, airplane mode keeping local data, and refresh stopping at the first failure.
- **Cubits:** the auth steps (double-tap guard, OTP lock and countdown), Home and Rewards sections, product detail (quantity, total, Add to cart) and connectivity.
- **Infrastructure:** result types, database migrations, network error mapping, components, navigation and app startup, including small phones at text scale 1.3 in Burmese.

GitHub Actions (`.github/workflows/ci.yml`) runs on every push and pull request to `master`:

1. regenerates code and localizations and fails if anything differs from what is committed;
2. checks formatting, runs `flutter analyze` and `flutter test`;
3. builds a release APK and attaches it to the run as a downloadable artifact.

## Known gaps

- **No integration test** for Register → Home → Product detail. The flow is covered by unit and widget tests instead.
- **60 fps was not measured** in profile mode on a device.
- No Hero flight on the iOS swipe-back gesture; the Back button flies it.
- Home's section entrance plays once per sign-in; Rewards replays its entrance on every visit.
- The cart is visual feedback only (nothing is stored). Orders and Wallet are placeholder tabs; social log-in, Terms and Privacy open a "coming soon" sheet.
- Tier thresholds are fitted to the brief's numbers (Silver 0, Gold 680,500, Platinum 900,000), so the Silver → Gold line is almost full.
- The third tab's name ("Orders") is inferred from the design icon.
- Release APKs are signed with the debug key: fine for test phones, not for a store release.

## Time spent

Approximate, over two days.

| Area | Time |
|---|---|
| Project setup (architecture, tokens, database, navigation, CI) | ~6.5 h |
| Task 1 — Auth | ~5 h |
| Task 2 — Home and Product (offline) | ~4 h |
| Task 3 — Rewards | ~5 h |
| Motion polish | ~1.5 h |
| Tests | ~0.5 h |
| README and delivery | ~0.5 h |
| **Total** | **~23 h** |
