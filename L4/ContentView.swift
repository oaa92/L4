import SwiftUI

struct ContentView: View {
    var body: some View {
        Button {} label: {}
        .buttonStyle(PlayNextButtonStyle())
    }
}

struct BackgroundButtonStyle: ButtonStyle {
    @Binding var performAnimation: Bool

    func makeBody(configuration: Configuration) -> some View {
        let scale: Double = performAnimation ? 0.86 : 1
        let duration = 0.22
        let opacity: Double = performAnimation ? 0.25 : 0

        configuration.label
            .animation(.linear(duration: duration)) {
                $0
                    .background() {
                        Circle()
                            .fill(Color.secondary)
                            .frame(width: 100, height: 100)
                            .opacity(opacity)
                    }
                    .scaleEffect(scale)
            }
    }
}

struct PlayNextButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ButtonView(performAnimation: configuration.isPressed)
    }
}

struct ButtonView: View {
    @State var performAnimation = false

    var body: some View {
        Button {withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
            performAnimation.toggle()
        } completion: {
            performAnimation.toggle()
        }}
        label: {
            PlayImagesView(performAnimation: $performAnimation)
                .frame(maxWidth: 64, alignment: .center)
        }
        .buttonStyle(BackgroundButtonStyle(performAnimation: $performAnimation))
    }
}

struct PlayImagesView: View {
    @Binding var performAnimation: Bool
    let width: Double = 32

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            PlayImage()
                .frame(width: performAnimation ? width : .zero)
                .opacity(performAnimation ? 1 : .zero)

            PlayImage()

            PlayImage()
                .frame(width: performAnimation ? 0.5 : width)
                .opacity(performAnimation ? .zero : 1)
        }
    }
}

struct PlayImage: View {
    var body: some View {
        Image(systemName: "play.fill")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.accentColor)
    }
}

#Preview {
    ContentView()
}
