import SwiftUI

struct ContentView: View {
    @State private var performAnimation: Bool = false

    var body: some View {
        Button {
            withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)){
                performAnimation.toggle()
            }
            completion: {
                performAnimation.toggle()
            }
        } label: {
            GeometryReader(content: { geometry in
                let width = geometry.size.width / 2

                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "play.fill")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? width : .zero)
                        .opacity(performAnimation ? 1 : .zero)

                    Image(systemName: "play.fill")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()

                    Image(systemName: "play.fill")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            })
        }
        .frame(maxWidth: 62)
    }
}

#Preview {
    ContentView()
}
