import SwiftUI

/// A line being displayed in the output.
struct AdventureGameLine: Identifiable {
    let id = UUID()
    let content: AttributedString
}

/// Model that manages interaction between the UI and the game logic.
class AdventureGameModel<Game: AdventureGame>: AdventureGameContext, ObservableObject {
    /// The current game.
    ///
    /// Re-created on reset.
    @Published var game = Game()
    
    /// The line of input being entered.
    @Published var input = ""

    /// Whether the game has ended.
    @Published private(set) var isEnded = false
    
    /// The list of lines being displayed in the output.
    @Published private(set) var lines = [AdventureGameLine]()
    
    public func write(_ attributedString: AttributedString) {
        lines.append(AdventureGameLine(content: attributedString))
        
        // Prevent lines from getting too long
        let threshold = 1000
        if lines.count > threshold {
            lines.removeFirst(lines.count - threshold)
        }
    }
    
    public func endGame() {
        isEnded = true
    }
    
    init() {
        game.start(context: self)
    }
    
    /// Resets the game by re-initializing the game logic, resetting UI state,
    /// and calling the start method again.
    func reset() {
        game = Game()
        input = ""
        isEnded = false
        lines = []
        game.start(context: self)
    }
    
    /// Submits the current line of input to the game logic.
    func submit() {
        var inputAttributedString = AttributedString(input)
        inputAttributedString.swiftUI.font = .body.bold().italic()
        inputAttributedString.swiftUI.foregroundColor = .primary.opacity(0.6)
        
        lines.append(AdventureGameLine(content: inputAttributedString))
        game.handle(input: input, context: self)
        input = ""
    }
}
