import Cocoa

/// Plays an introductory song!
public func playIntroduction() {
    let url = URL(string: "https://www.youtube.com/watch?v=xvFZjo5PgG0")!
    NSWorkspace.shared.open(url)
}
