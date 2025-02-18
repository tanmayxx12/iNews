
# iNews
A modern iOS news application that provides users with real-time access to news articles from various categories. The app utilizes the NewsAPI to fetch current
news articles and presents them in a clean, user-friendly interface following Apple's Human Interface Guidelines.

## Features

### Core Features
- **Dynamic News Feed**: Browse through latest news articles from multiple categories
- **Category Navigation**: Quick access to different news categories including:
  - Top Headlines
  - Technology
  - Business
  - Entertainment
  - Health
  - Science
  - Sports

### Search Functionality
- **Article Search**: Search for specific news articles
- **Search History**: Track and access recent searches
- **Quick Access**: Tap on recent searches to quickly revisit previous queries

### Bookmarking System
- **Save Articles**: Bookmark interesting articles for later reading
- **Bookmark Management**: Easy access to saved articles
- **Persistent Storage**: Bookmarks are preserved between app sessions

### Article Sorting
- **Date-based Sorting**: Toggle between newest and oldest articles
- **Dynamic Updates**: Instant reordering of articles based on sort preference

### User Interface
- **Modern Design**: Clean and intuitive interface following iOS design principles
- **Responsive Layout**: Adaptive design that works across different iPhone models
- **Loading States**: Smooth loading transitions with progress indicators
- **Scroll Behavior**: Smooth scrolling with lazy loading for optimal performance

## 🛠 Tech Stack

### Frontend
- SwiftUI
- Combine Framework
- Async/Await for concurrency

### Architecture
- MVVM (Model-View-ViewModel)
- Observable Object Pattern
- Protocol-Oriented Programming

### Data Management
- UserDefaults for local storage
- Codable protocol for data serialization
- URLSession for network requests

### APIs
- NewsAPI for fetching articles
- Native iOS frameworks

## Deployment

### Requirements
- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+
- Active NewsAPI key

### Installation

-Clone the repository
```bash
git clone https://github.com/tanmayxx12/iNews
```

- Open the project in **XCode**
``` bash
  open Weatherly.xcodeproj
```

- Add your NewsAPI key in the configuration
- Create a `Config.swift` file
- Add your API key:
```swift
struct Config {
    static let apiKey = "YOUR_API_KEY"
}
```

- Build and run the project in Xcode

### API Configuration
To use this application, you'll need to:
1. Sign up for a free API key at [NewsAPI](https://newsapi.org)
2. Add the API key to your project configuration
3. Ensure you comply with NewsAPI's terms of service and usage limits


## 🤝 Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

