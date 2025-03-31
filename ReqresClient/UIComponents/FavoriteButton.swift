import SwiftUI

struct FavorButton: View {
    @State var isFavored = false
    var customAction: (Bool) -> Void

    var body: some View {
        Button(
            action: {
                isFavored.toggle()
                customAction(isFavored)
            },
            label: {
                HStack {
                    Image(systemName: isFavored ? "suit.heart" : "heart.fill")
                        .foregroundColor(isFavored ? .white : .pink)
                    Text(isFavored ? "Unfavor" : "Favor")
                }
                .frame(width: 120, height: 50)
                .background(isFavored ? Color.pink : Color.clear)
                .foregroundColor(isFavored ? .white : .pink)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.pink, lineWidth: 2)
                )
                .cornerRadius(10)
            }
        )
        .animation(.easeInOut, value: isFavored)
    }
}

struct FavorButton_Previews: PreviewProvider {
    static var previews: some View {
        FavorButton { _ in }
    }
}
