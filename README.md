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
- scrolling animates the header view height


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

# Screenshots
- dark mode
![Simulator Screen Shot - iPhone 14 Pro Max - 2022-11-11 at 04 18 11](https://user-images.githubusercontent.com/92518636/201256514-a5c252e1-63b9-42eb-9ff6-0599340f515b.png)


- light mode
![Simulator Screen Shot - iPhone 14 Pro Max - 2022-11-11 at 04 18 32](https://user-images.githubusercontent.com/92518636/201256544-57697012-0e07-4831-9cf8-349188d97a36.png)

- animated header
https://user-images.githubusercontent.com/92518636/201256592-3012d81e-27e6-4b09-9789-67441f6c70ab.mp4

