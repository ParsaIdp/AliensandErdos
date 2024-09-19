import SwiftUI
import PlaygroundSupport

/// A type that represents an Adventure game's state, behavior, and gameplay.
public protocol AdventureGame {
    /// Creates a new game.
    init()
    
    /// Title to be displayed at the top of the game.
    var title: String { get }
    
    /// Runs at the start of every game.
    /// - Parameter context: The object you use to write output and end the game.
    mutating func start(context: AdventureGameContext)
    
    /// Runs when the user enters a line of input.
    /// - Parameters:
    ///   - input: The line the user typed.
    ///   - context: The object you use to write output and end the game.
    mutating func handle(input: String, context: AdventureGameContext)
}

/// An object that handles displaying output and ending the game.
public protocol AdventureGameContext {
    /// Adds the given line of rich text to the output.
    /// - Parameter attributedString: Rich text string to display.
    func write(_ attributedString: AttributedString)
    
    /// Ends the game immediately.
    ///
    /// Note that this function does not itself output a game over message.
    func endGame()
}

public extension AdventureGame {
    /// Sets up a UI and runs the game in the playground.
    static func display() {
        PlaygroundPage.current.setLiveView(AdventureGameView<Self>())
    }
}

public extension AdventureGameContext {
    /// Adds the given line to the output, without rich text formatting.
    /// - Parameter string: String to display.
    func write(_ string: String) {
        write(AttributedString(string))
    }
}
