# PokedexUIKit

| PokemonsList                        | MovesList                     |
| ----------------------------------- | ----------------------------- |
| ![PokemonsList](./PokemonsList.gif) | ![MovesList](./MovesList.gif) |

### Initial Build Setup for iOS App

- Clone the project.

- Xcode 12 installed. 

- Carthage  v0.36.0 installed.

- Swift Lint v0.39.1 installed.

- Open another tab on the terminal, go to the inside pokedexUIKit folder where Carfile is located, and run:

   ````bash
  carthage bootstrap --platform iOS --use-xcframeworks
  ````

- Open `pokedexUIKit.xcodeproj`. 

- In Xcode,  select a device.

- Build & Run.

### Architecture

* MVVM 
* Factory Pattern
* Facade Pattern
* Delegate Pattern

### Highlights

* Created [MRCommons framework](https://github.com/mruiz723/MRCommons-iOS) that helps us with the bindable using the property observer. This framework is done with SPM and XCFramework. That allows us to avoid fat framework and finally put .zip XCFramework to offer to whatever person wants to download the framework.
* Created custom implementation from URLSession to make the requests instead of using third party library like Alamofire.

