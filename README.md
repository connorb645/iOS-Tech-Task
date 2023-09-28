
# Moneybox iOS Tech Task

## Composition Root (AppBootstrap)
The Composition Root, or AppBootstrap, is a key part of the app's architecture. It sets up all the dependencies the app needs. This includes setting up the initial UIWindow and using the LaunchCoordinator to start the right child coordinator, which could be based on the app's state - like user auth.

This setup makes sure all dependencies are managed in one place and that the app's flow is controlled centrally, making the codebase easier to manage and test.

## Dependency Graph
The app is designed to be modular, with different Swift Packages responsible for different parts of the app's functionality. Here's a quick rundown of the packages:

- **Networking**: This package handles all network-related tasks. It contains the API calls and manages the communication with the server. It also includes error handling for network requests.

- **Coordinating**: This package defines a navigatable interface. It manages the flow of the app and coordinates between different screens. It makes sure the right screen is displayed at the right time.

- **Core**: This package contains shared code which is standalone. It includes utilities, helpers, and common classes that are used across the app. This package is designed to be independent and reusable.

- **CoreUI**: This package contains shared UI elements. It includes custom views, styles, and themes that are used across the app. This helps in maintaining a consistent look and feel throughout the app.

- **FeatureLogin**: This package depends on Core, Coordinating, Networking, CoreUI. It builds the login screen UI and all of its business logic. It includes the UI elements for the login screen, validation of user input, and handling the login process. It also includes tests to ensure the functionality of the login feature.

- **FeatureAccounts**: This package is similar to FeatureLogin, but it has 2 screens which it is responsible for - Accounts List and Product Detail screens. It includes the UI elements for these screens, the logic for fetching and displaying the account details, and handling user interactions. It also includes tests to ensure the functionality of these features.

The modular design of the app allows for independent development of different features. For instance, two different teams can work on the FeatureLogin and FeatureAccounts packages independently. All they would need is their own base app which would bundle just their feature module along with its dependencies. This approach promotes parallel development and reduces dependencies between teams, leading to increased productivity and faster delivery times. Additionally, this structure significantly reduces the likelihood of merge conflicts and reduces compilation times, making the development process smoother and more efficient.


## Accessibility
The app supports VoiceOver, a powerful accessibility feature in iOS for users who are visually impaired. By providing spoken descriptions of what's on the screen, VoiceOver enables these users to interact with the app and perform actions that would otherwise require sight. This commitment to accessibility ensures that our app can be used by a wider range of people, making it more inclusive and user-friendly.

## MVVM-C
The app uses the MVVM-C (Model-View-ViewModel-Coordinator) design pattern. This pattern is a great choice for iOS projects as it provides a clear separation of concerns, making the codebase easier to manage and test. The MVVM-C pattern also promotes a high degree of decoupling, which is further enhanced by the Composition Root in this app.

In the MVVM-C pattern, the ViewModel handles the business logic and provides data for the View, which is responsible for displaying the UI. The Model represents the data and the Coordinator manages the navigation logic. This separation allows for better testability and easier maintenance of the codebase.

## Unit Testing
Unit tests have been added for the ViewModels in the application. These tests ensure that the business logic in the ViewModels is working as expected. They test the interaction between the ViewModel and the Model, and ensure that the ViewModel correctly processes the data from the Model and provides the correct output for the View.

It's worth noting that while unit tests are a crucial part of ensuring the reliability and stability of the app, they are not the only form of testing that can be used. However, in this case, UITesting has been omitted as per the specification stating they are not required. This decision was made to focus on the core functionality of the app, and to ensure that the business logic is sound.

## Dark/Light Mode
The app supports both light and dark mode. A consistent colour palette is used for both modes, which is provided by the Assets.xcassets file within the main app bundle. This ensures a seamless user experience when switching between modes.

## Haptic Feedback
The app incorporates haptic feedback to provide a more intuitive and immersive user experience. Haptic feedback is used to give users a tactile response when performing certain actions within the app. This can help users understand that their actions have been registered by the app, providing a more satisfying user experience.


## Test User
The following user can be used to authenticate

|  Username          | Password         |
| ------------- | ------------- |
| test+ios2@moneyboxapp.com  | P455word12  |

## Authentication
Authentication in this app expires every 5 minutes and the authToken is not persisted across app launches. This is a security measure to avoid storing the user's password within the app bundle. To support persistent authentication, a refresh token should be returned in the login response. This refresh token can be used to renew the authToken when it expires.

### How to Submit your solution:
 - To share your Github repository with the user valerio-bettini.

## Thank you, I really enjoyed this!
