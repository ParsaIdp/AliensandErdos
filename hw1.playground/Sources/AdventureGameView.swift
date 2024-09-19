import SwiftUI

/// The game UI.
struct AdventureGameView<Game: AdventureGame>: View {
    /// Corner radius of the UI.
    static var cornerRadius: CGFloat { 16 }
    
    /// The underlying game model.
    @StateObject var model = AdventureGameModel<Game>()
    
    /// Special ID denoting the bottom of the view.
    let bottomId = "bottom"
    
    /// Header containing the title and a reset button.
    var header: some View {
        VStack(spacing: 0) {
            HStack {
                Text(model.game.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Spacer()
                Button("Reset") {
                    model.reset()
                }
            }
            .padding()
            Divider()
        }
        .background(.regularMaterial)
    }
    
    /// View displaying the current output.
    var output: some View {
        ScrollView {
            ScrollViewReader { proxy in
                let content = VStack(alignment: .leading, spacing: 8) {
                    ForEach(model.lines) { line in
                        Text(line.content)
                    }
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 0)
                        .padding(.bottom)
                        .id(bottomId)
                }
                .padding([.top, .horizontal])
                .frame(width: 480, alignment: .leading)
                
                // Whenever we add a line, scroll to the bottommost line
                //
                // macOS Sonoma changed up the way onChange works, but we still
                // need to support macOS Ventura, hence the #available check
                if #available(macOS 14.0, *) {
                    content.onChange(of: model.lines.last?.id) {
                        proxy.scrollTo(bottomId, anchor: .bottom)
                    }
                } else {
                    content.onChange(of: model.lines.last?.id) { _ in
                        proxy.scrollTo(bottomId, anchor: .bottom)
                    }
                }
            }
        }
    }
    
    /// Footer displaying the input text box.
    var footer: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                TextField("Input", text: $model.input)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        model.submit()
                    }
                
                Button {
                    model.submit()
                } label: {
                    Label("Submit", systemImage: "arrow.forward")
                        .labelStyle(.iconOnly)
                }
                .keyboardShortcut(.defaultAction)
            }
            .disabled(model.isEnded)
            .padding()
        }
        .background(.regularMaterial)
    }
    
    var body: some View {
        output
            .safeAreaInset(edge: .top, spacing: 0) {
                header
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                footer
            }
            .background(.black)
            .environment(\.colorScheme, .dark)
            .frame(height: 640)
            .controlSize(.large)
            .clipShape(RoundedRectangle(cornerRadius: Self.cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: Self.cornerRadius)
                    .stroke(.quaternary)
            }
            .padding()
    }
}
