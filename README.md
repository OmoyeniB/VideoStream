# VideoStream


#App Overview:
 An app that performs queries to firebase database and shows the users data displaying only the post that are videos. The app makes a request to the firebase, then the post data is saved to realm. which is then displayed in the UI. 

#Main Components: The app consists of these main components:
- Request to Firebasedatabase
- data saved to RealmSwift
- Avkit and AVFoundation to load and stream the video urls
- implemented Dark mode and light mode enabled
- avoided strong retain cycle by making self weak and unwrapping where necessary.
- automatically cached images with sdwebImage


#Dependencies Used:
- Firebase
- SDWebImage
- Snapkit
- RealmSwift

#Architecture Used:
- MVVM Architecture was implemented with adherance to the DRY principle, creating extensions and helpers where needed. to ensure separation of concerns and proper decoupling of code around the application.

#Performance Improvement
- Image caching, this saves the user's time and data

- Activity indicators to notify users of tasks

#Requirements:

- iOS Version ~> 11

- Xcode ~> 13 (10.0 compatible)

- Swift ~> 5.0

#Installation

- Clone the repository

$ git clone https://github.com/OmoyeniB/VideoStream.git

$ cd Github Search

- Open the file Github Search.xcodeproj using Xcode and allow xcode to resolve the project.

- Click on the play button at the top left corner to build and run the project Architecture

