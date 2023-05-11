# edusphere

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Let's take a closer look at each folder:

common: This folder contains common elements used throughout the application, such as constants, enums, and utility functions.

constants: Stores application-wide constants.
enums: Contains enums used in the app.
utils: Contains utility functions and helper classes.
data: This folder handles all data-related operations, including data models, repositories, and state management.

models: Contains data models or POJO (Plain Old Java Object) classes.
repositories: Manages data sources, including API calls, database interactions, etc.
providers: Contains state management classes using packages like Provider, Riverpod, or MobX.
presentation: This folder contains UI-related files, including screens, widgets, and themes.

screens: Contains individual screens or pages of the app.
widgets: Stores reusable widgets used across different screens.
themes: Contains theme-related files, including colors, fonts, and styles.
services: This folder handles different services or external integrations.

api: Contains API service classes for making network requests.
database: Manages database-related operations or local data storage.
main.dart: The entry point of your Flutter app, where you configure the app's initial setup and define the root widget.