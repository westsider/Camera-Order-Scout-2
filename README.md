![alexamini_180](https://cloud.githubusercontent.com/assets/19356639/23538446/13e6dc40-ff88-11e6-86b5-7d56fb77575d.png)
#Camera Order 
is an iOS application for for cinematographers to create and maintain equipment lists used in motion picture productions. This application was created as my Udacity iOS Nanodegree Program capstone project submission.
#Intended Experience
Upon opening the app, a sample order is displayed for viewing, editing and eventually sharing. The list displayed is what is currently on the order. A swipe left deletes item. To add equipment use the picker above the list to select a new item and then add it to the order with the add button. Share your list by pressing… you guessed it - Share. Your opinions include email and sms as well as twitter, Facebook, iCloud etc.
Your project particulars can be edited by tapping the top item where you see the user and director of photography. That will open up another view so you can change the project name, add pertinent information and even get a weather forecast.
You can maintain as many projects as you like by tapping Project on the left in the main screen. This allows you to save the current project or load a prior one.
Your current project is always saved for the next time you launch Camera Order. This app also remembers equipment you have previously requested and suggests those items inside of the aks, filters and support items.
#Running the app
After cloning the repository, ensure you're on the master branch and open the application in Xcode. You should then be able to run the app in simulator or on a compatible device. Note that Camera Order is written to compile in Xcode 8.2 and Swift 3.0.2.
#External APIs and Data
Weather data available in the app was gleaned from Wunderground. Camera Order loads this external data via [Wunderground Weather API](https://www.wunderground.com/weather/api/). This app persists date using [Realm](https://realm.io/) and [NSUserDefaults](https://developer.apple.com/reference/foundation/userdefaults).

