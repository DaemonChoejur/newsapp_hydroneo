# Paper News - HydroNeo

Paper News, a news app using Rapid API (Google News)

---

# About the app

1. Show news based on Topics such as World, Business, Technology, etc.
2. News are cached using Hive NoSQL Database
3. Save news to favourites (Bookmark it)

---

# How to use

---

Step 1:
Download or clone this repo using the link below:

```
https://github.com/DaemonChoejur/newsapp_hydroneo.git
```

Step 2:
Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

Step 3:
This project uses flutter_dotenv package which requires you to create an .env file
Create a .env file and place it in your assets folder.
Contents of the .env file are as follows:

```
API_KEY = [YOUR_API_KEY_HERE]
DEV_API_KEY = [YOUR_API_KEY_HERE]
```

I have used 2 API keys in the news_api.dart file found in api folder under lib.
Checking where its running on release more or not since the API key has a hard rate limit

```
kReleaseMode ? dotenv.get('API_KEY') : dotenv.get('DEV_API_KEY2')
```

---

# Libraries and Tools used

- [Url Launcher](https://pub.dev/packages/url_launcher)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- [Flutter Dotenv](https://pub.dev/packages/flutter_dotenv)
- [Provider](https://pub.dev/packages/provider)
- [Intl](https://pub.dev/packages/intl)
- [Dio](https://pub.dev/packages/dio)
- [Http](https://pub.dev/packages/http)
- [Pretty Dio Logger](https://pub.dev/packages/pretty_dio_logger)
- [Hive](https://pub.dev/packages/hive)
- [Cached Network Image](https://pub.dev/packages/cached_network_image)

# Folder Structure

```
PaperNewsApp/
|- android
|- build
|- ios
|- lib
|- test
```

folder structure in project

```
lib/
|- api/
|- blocs/
|- common/
|- models/
|- notifiers/
|- repository/
|- ui/
|- app.dart
|- constants.dart
|- main.dart
```

# Api

This directory contains the network calls

```
api/
|- news_api.dart
|- news_image_url_api.dart
```

# Blocs

This directory contains Blocs

```
blocs/news_bloc
|- news_bloc.dart
|- news_event.dart
|- news_state.dart
```

# Common

This directory contains the files that are used throughtout the app such as in this case, Theme

```
common/
|- theme.dart

```

# Models

This directory contains the models classes.

```
models/
|- article_list.dart
|- article_list.g.dart
|- article.dart
|- article.g.dart
|- models.dart
|- news_response.dart
|- source.dart
```

# Notifiers

This directory contains the notifiers (Change Notifier)

```
notifiers/
|- article_notifier.dart
|- topics_notifier.dart
```

# Repository

This directory contains repositories

```
repository/
|- boxes.dart
|- hive_repository.dart
|- irepository.dart
|- news_repo.dart
|- storage_manager.dart
```

# UI

This directory contains the presentation layer files

```
ui/
|- components/
|- favourite_news_list.dart
|- home.dart
|- topics_bottom_sheet.dart
```

# Components

```
ui/components
|- drawer.dart
|- news_thumbnail_widget.dart
|- news_widget.dart
|- pull_widget.dart
|- thumbnail_widget.dart
```

# Conclusion

Thank you for taking the time to go through my project.

# © AlphaNapster 2022
