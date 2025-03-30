import Combine

final class UserDetailsViewModel<DP: NetworkDataProvider> {
    let userInfo = PassthroughSubject<User, Error>()

    init(userDataProvider: DP, userID: Int) {
        Task { userInfo.send(try await userDataProvider.getUserInfo(byID: userID)) }
    }
}
