# Template iOS  Project

## Specifications
- Swift 5.9+
- iOS 17.0+
- SPM as sole dependencies manager

## Architectural concepts
- **Clean architecture** with isolated *Data, Domain, Application* and *Presentation* layers as *Swift Packages* (largely inspired by [this article](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3) and [this repo](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM))
- **UIKit** based app, leveraging **Flow Coordinators** for navigation and **SwiftUI** prioritized for *UI* implementation (inspired and reassured by [Airbnb's experience with SwiftUI](https://medium.com/airbnb-engineering/unlocking-swiftui-at-airbnb-ea58f50cde49))
- **MVVM** using built-in Swift **[Observation](https://developer.apple.com/documentation/observation)** framework for data binding
- *Dependency Injection* service used across the app for dependencies management
- *Multiple environments* support with ability to change the environment during the lifetime of the app
- Any layer of the app including the Presentation layer is **fully testable**

## The template includes
- An end-to-end flow of data from the API to the UI and to the local database
- Searchable paginated list of movies (using the [Movie DB API (https://www.themoviedb.org/)] )
- Example unit tests for every layer from Data to Presentation
- Loading, error and ready UI states encapsulated in reusable view
- Modal, toasts and alerts
- UI previews leveraging using mocked data

## Libraries
#### [Papyrus](https://github.com/joshuawright11/papyrus)
Papyrus is a set of macros that are built over URLSession, it greatly simplifies the api endpoints management. Papyrus is inspired by [Square's retrofit](https://square.github.io/retrofit/) package, which is the golden standard for mobile api designs.

#### [KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)
KeychainAccess is a simple Swift wrapper for Keychain. Makes using Keychain APIs extremely easy and much more palatable to use in Swift.

#### [Swinject](https://github.com/Swinject/Swinject)
Swinject is a lightweight dependency injection framework for Swift. It provides a very flexible DIContainer implementation that removes the burden of creating and maintaining instances in the applications.

#### [PublicInitialiserMacro](https://github.com/lutes1/PublicInitialiserMacro)
Empty public initializer generator

#### [Instabug](https://github.com/Instabug/Instabug-SP)
Bug and analytics tracker of choice

#### [Nuke](https://github.com/kean/Nuke)
A framework for efficiently downloading and caching Images (inspired by [this article](https://www.avanderlee.com/swiftui/downloading-caching-images/))
