import SwiftUI

struct UserImage: View {
    let source: String

    var body: some View {
        AsyncImage(url: URL(string: source)) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color.white
                    ProgressView()
                }
            case .failure(let error): Text(error.localizedDescription)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            @unknown default:
                fatalError("State is not implemented")
            }
        }
        .clipShape(Circle())
    }
}

#Preview {
    UserImage(source: "https://reqres.in/img/faces/8-image.jpg")
}
