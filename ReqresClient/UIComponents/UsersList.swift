import SwiftUI

struct UsersList: View {
    var data: [User.UserData]
    var state: UserViewState
    var fetchMore: (Int) -> Void

    var body: some View {
        ZStack {
            List {
                ForEach(data, id: \.id) { userData in
                    NavigationLink(value: userData) {
                        UserCell(source: userData)
                            .onAppear { fetchMore(userData.id) }
                    }
                }
            }
            .navigationTitle("Users")
            .listStyle(.inset)

            if state == .loading {
                ProgressView()
            }
        }
    }
}

#Preview {
    UsersList(data: [.example], state: .idle) { _ in }
}
