# CodeChallenge for For-Qantas-Loyalty
by _Dmitrii Zverev_. 26 June 2018

<h2>Create an iOS app that displays recipes.</h2>



- [x] The data can be obtained from https://g525204.github.io/recipes.json

- [x] In the first screen of the app, display a list of the recipes loaded from the API. Some of the recipes returned by the API will have an image, some won't. 

- [x] The list should contain two sections - the first section will display recipes that have images, with the header "Popular"; while the second section will display recipes that do not have images, with the header "Other". 

- [x] The two sections should scroll as a single scroll container.

- [x] The first section will display each recipe as a tile, with the image filling the entire tile. 

- [x] The title of the recipe should be overlaid on the image, aligned to the bottom right corner of the tile. It should wrap if it is too long to fit in one line. 

- [x] This section should display two columns of tiles when the device is in portrait mode, or three columns when it is in landscape mode.

- [x] **Bonus points if you can make each tile a perfect square (but this is not strictly a requirement for the task).**

- [x] The second section will simply display each recipe's title, left-aligned as a list item with no image.

- [x] When the user taps on one of the items, perform a slide-left transition to a recipe details screen that displays the recipe's image, title, ingredients. You can lay out this screen in any way you like, with whatever UI components you choose, as long as it displays all the information clearly. 

- [x] When this screen transitions back to the first screen, it should be a slide-right transition.

- [x] The recipe details screen should also display the URL of the recipe as a clickable link (not a button). 

- [x] When the link is clicked, open the URL in an in-app browser.

- [x] The screen transition to the in-app browser should be a slide-up transition. When the browser screen transitions back to the recipe details screen, it should be a slide-down transition.



<h2>Personal challenges:</h2>

 **In this challenge, I demonstrated that I know how to use:**
 
- structs
- lazy variables
- optional 
- Codable 
- class extensions and sub-classes
- Threads
- URL Sessions
- Error throwing Enums
- Creating UI elements without Storyboard/Xib
- Avoiding Massive View Controllers
- writing code without single warning 
- closures
- escaping
- tuples 
- Image Caching
- Unit Testing
- ..  and much more 

__Unit testing:__
To display that I know what unit tests are and how to write them, I implemented some examples including the _Asynchronous URL Connection test_.
