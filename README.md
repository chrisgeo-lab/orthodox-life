# Orthodox Life ☦️

Orthodox Life is an attempt to centralize data relevant to Greek Orthodox Christians, primarily in America. 

## Current Capabilities 📱
The app currently has three rudimentary pages - a home page, a prayer book, and a readings tab:
<ul>
<li>The home page updates directly from https://www.goarch.org/ daily to retrieve information regarding feast days and fasting.</li>

<li>The prayer book page allows users to cycle through different existing prayers, and leave a 'heart' to favorite prayers.</li>

<li>The readings tab only has two real readings, both of which are dynamic and update from https://www.goarch.org/ - the daily Epistle and Gospel lessons.</li>
</ul>

<img src="orthodox-life-demo.gif" width="300"/>

## Improvements Upon Existing 🔧
The current state of the app can be improved in a variety of ways. To begin, the home page could be more inviting, and there are issues with the displayed image that updates daily. Because the image is arbitrarily cropped, it sometimes crops so that relevant infromation from the image is not dispalyed. 

Furthermore, the method for getting and storing data could drastically be improved. Currently the app checks if data has changed on startup, and will webscrape and store information locally. However, this process is not isolated from building and displaying the home page.

Lastly, the information in the prayer book tab is all local to the app. The information should be stored in a separate databse so that prayers may be added/changed without the app needing an update.

## Future Vision 👁️
There is much more information I would like to include in this app. 

First, I would like to add pages so that users can read more about the daily feast, or the saints that are celebrated each day. Currently users can read what or who is being celelbrated, but are unable to learn more from within the app: this needs to change, but could require some tricky thinking.

Second, I would like to add a calendar tab so that users can explore information beyond or before the current date. I want this information to be accessible without ruining the simplistic user experience.

Finally, I would like to incorporate a multimedia page - links to church livestreams, RSS feeds for popular Orthodox podcasts, and possible even relevant articles. This is the cherry on top for the app, as it will allow the user to connect and interact in more ways.



