# Project 1 - *Flicks*

**Flicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **6** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] User sees an error message when there's a networking error.
- [x] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [ ] Customize the UI.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/CEDohIC.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

I was having trouble getting the search function to work. I think I was starting to get a decent idea of what was wrong, but I ran out of time and had to submit my work. In the future I need to get started on the optional features earlier.

~~There also exists a bug where the app crashes when you try to search and there are no movies to search during network errors. Also, in the transition to a collection view, you can no longer pull down to reload when no movies are shown.~~

Fixed bugs and got search to work. Too bad it's after the deadline lol.

I didn't want to work on customizing the UI because I wanted a better idea of how the whole app would look since we're building upon this app on next week's project.

Keyboard is dismissed when attempting to scroll on CollectionView. For some reason I can't figure out why tapping on the screen won't dismiss the keyboard.

## License

    Copyright 2016 Isaias Suarez

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

# Project 2 - *Flicks 2: The Flickening*

**Flicks** is a movies app displaying box office and top rental DVDs using [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **4** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view movie details by tapping on a cell.
- [x] User can select from a tab bar for either **Now Playing** or **Top Rated** movies.
- [x] Customize the selection effect of the cell.

The following **optional** features are implemented:

- [x] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] Customize the navigation bar.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Is there a better way to add transparency to the navigation bar other than putting a transparent view under it? 
2. What are some more interesting ways to visualize selections for a CollectionView other than putting a border around your selection?

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/CEDohIC.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

I had some trouble figuring out how to add transparency to the navigation bar at the bottom. I also had a trouble figuring out how to deselect an item in the collection view since the documentation on the course website only covered table views.

There are a couple things that I would like to improve if I had the time, such as adding padding at the bottom of the detail view so text doesn't end up behind the nav bar for long synopses and adding more helpful details in the detail view such as rating and nearby theaters that are playing the movie.

## License

    Copyright 2016 Isaias Suarez

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
