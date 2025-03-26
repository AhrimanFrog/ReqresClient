import SwiftUI

struct UserCell: View {
    let source: User.UserData

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: source.avatar))
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("\(source.firstName) \(source.lastName)")
                    .foregroundStyle(.primary)
                Text(source.email)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    UserCell(
        source: .init(
            id: 7,
            email: "michael.lawson@reqres.in",
            firstName: "Michael",
            lastName: "Lawson",
            avatar: "https://reqres.in/img/faces/7-image.jpg"
        )
    )
}
