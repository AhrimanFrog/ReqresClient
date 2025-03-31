import SwiftUI

struct UserCell: View {
    let source: UserData

    var body: some View {
        HStack {
            UserImage(source: source.avatar)
                .frame(width: 80, height: 80, alignment: .leading)
            VStack(alignment: .leading) {
                Text(source.fullName)
                    .foregroundStyle(.primary)
                Text(source.email)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    UserCell(source: .example)
}
