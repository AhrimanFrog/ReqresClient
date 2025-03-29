import SwiftUI

struct UserCell: View {
    var source: User.UserData

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: source.avatar))
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .frame(alignment: .leading)
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
    UserCell(source: .init(id: 1, email: "kuk.con", firstName: "Kuk", lastName: "ivanovich", avatar: "https://reqres.in/img/faces/8-image.jpg"))
}
