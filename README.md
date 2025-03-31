# Setup instructions
- Clone project using `git@github.com:AhrimanFrog/ReqresClient.git`
- Open project in Xcode
- Wait until Package Manager resolves dependencies
- Select iPhone as a target device
- Press "Build & Run"

# Brief implementation details
### Screen Factory
All dependencies are contained in a fabric class `Repository`. This class is responsible for building and providing a `View`.

### Data models
Classes and structs are used for data models. 
Structs are used for decoding and passing between viewModels and views. 
Classes are used to preserve data in Realm database.

### Managers
`PersistanceManager` and `NetworkManager` are responsible for data preservation and network calls respectively
Only "support" text is being updated when "Details" view is open. 

# Completed features & limitations
- All screens: Users, Favorites, User details
- Refresh on Users screen
- Favoring user on "User details" screen
- Deletion of favored user on "Favorites" screen
- Sync between screens: user "favor" status updates if you unfavor on "Favorites" screen and switch back to "Details" and wise-versa
- Infinite scroll
