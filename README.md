# CodeGMS-iOS

**I present to you the ColeGMS application, which will allow video game fans to register their collection while keeping up to date with the latest news.**

- **Basic Operation:**
  Navigating through the application is very fast and intuitive. There are two distinct parts to highlight:
    - First, from the left menu button we can access the news tab related to the world of video games and part of the world of entertainment in general.
    - On the other hand, we will find the "All games" and "My collection" screens. In the first one, you will have a lot of known games. If you are interested in a particular game, you can click on it and see information about where it can be purchased, genres, several screenshots, etc. But the most interesting feature is that by clicking on the heart in the upper right corner, you will indicate that you have added that game to your collection. Add all the games you consider, and you can view them in the last screen, the collection screen, which allows you to easily keep track of the games you own, and you can add additional fields such as the price you paid for them or what edition you have (physical/digital). And if at some point you don't want to keep any of the games in your collection, deleting it would be as easy as clicking the "Edit" button and selecting it. In both screens, you will have a search engine that will help you to visualize a specific game.

- **Technical Aspects:**
  In a nutshell, the application consists of connecting to the GameSpot and RAWR APIs to display news and games, respectively. It is completely coded in the Swift programming language and follows the MVVM architecture. The general structure of the project is as follows:

  - **Services:** Contains the connections to the APIs with all the corresponding configuration.
  - **Models:** Contains the New, Game, and Favorite (game added to the collection) entity classes.
  - **ModelViews:**
  - **Views:** Contains all the system views, that is to say, its files are the ones that dictate how what we see on the screen is structured.
  - **ContentView.swift:** This file defines the navigation between screens and establishes the aesthetics of the menu that controls that navigation (the three buttons).
  - **CodeGMSApp.swift:** Initializes the main view (ContentView) and provides the necessary keys for the connection with the APIs.

- **Initial Configuration:**
  The app is already configured, and the user can start it without additional changes. Optionally, the user can decide to generate his own keys for the APIs, after which he will have to modify them in CodeGMSApp.swift.
