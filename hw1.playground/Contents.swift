import SwiftUI

enum Direction: String {
    case north, east, south, west
}

struct Location {
    let name: String
    let description: String
    let directions: [Direction: String]
    var item: Interactable? = nil
}

struct Item {
    let name: String
    let description: String
    var isKeyItem: Bool = false
}

protocol Interactable {
    var name: String { get }
    var description: String { get }
    func interact() -> String
}

struct Key: Interactable {
    let name: String = "Answer Key"
    let description: String = "Ramsey number of (5, 5)"
    func interact() -> String {
        return "You picked up the answer! Give it to the aliens ASAP."
    }
}

struct GPT: Interactable {
    let name: String = "AI-generated solution"
    let description: String = "A wrong solution to the Ramsey number"
    func interact() -> String {
        return "You picked up the wrong answer! The Earth is doomed."
    }
}

struct YourGame: AdventureGame {
    var title: String {
        return "Aliens and Ramsey Number"
    }

    var currLocation: Location
    var playerItem: Item? = nil
    var foundPass: Bool = false
    var correctPass: String = "Kolmogrov"
    var inputPass: String?

    let entry: Location = Location(
        name: "Entry Room",
        description: "This is the entry room",
        directions: [.north: "Erdos House"]
    )

    let erdos: Location = Location(
        name: "Erdos House",
        description: "Aliens have invaded! Find the Ramsey number for red five and blue five or Earth will be destroyed.",
        directions: [.south: "Entry Room", .east: "Hallway"]
    )

    let hallway: Location = Location(
        name: "Hallway",
        description: "Who wrote the probability axioms?",
        directions: [.west: "Erdos House", .north: "Erdos Laptop"]
    )

    let laptop: Location = Location(
        name: "Erdos Laptop",
        description: "Enter the password to get the key. If wrong, you will get the wrong answer, and the Earth will be destroyed.",
        directions: [.south: "Hallway", .east: "Aliens"]
    )

    let aliens: Location = Location(
        name: "Aliens",
        description: "Give the correct answer to save the Earth.",
        directions: [.west: "Erdos Laptop"]
    )

    init() {
        currLocation = entry
    }

    mutating func start(context: AdventureGameContext) {
        context.write("Aliens have set a time bomb to destroy Earth unless you find the correct Ramsey number (5, 5).")
        context.write(currLocation.description)
    }

    mutating func handle(input: String, context: AdventureGameContext) {
        let arguments = input.split(separator: " ")
        if arguments.isEmpty {
            context.write("Please enter a command.")
            return
        }
        switch arguments[0].lowercased() {
        case "help":
            context.write("Available commands: north, south, east, west, look, take, enterpassword, inventory, useitem")
        case "north", "south", "east", "west":
            if let direction = Direction(rawValue: arguments[0].lowercased()) {
                move(direction: direction, context: context)
            } else {
                context.write("You can't move in that direction.")
            }
        case "look":
            context.write(currLocation.description)
        case "enterpassword":
            if currLocation.name == "Erdos Laptop" {
                if arguments.count > 1 {
                    inputPass = String(arguments[1])
                    checkPassword(context: context)
                } else {
                    context.write("You need to enter a password.")
                }
            } else {
                context.write("You can only enter the password in the Laptop room.")
            }
        case "take":
            if currLocation.name == "Erdos Laptop" {
                pickUpItem(context: context)
            } else {
                context.write("You can only take items in the Laptop room.")
            }
        case "inventory":
            showInventory(context: context)
        case "useitem":
            if currLocation.name == "Aliens" {
                useItem(context: context)
            } else {
                context.write("You can only use items in the Aliens room.")
            }
        default:
            context.write("Invalid Command.")
        }
    }

    mutating func move(direction: Direction, context: AdventureGameContext) {
        if let nextLocationName = currLocation.directions[direction] {
            switch nextLocationName {
            case "Erdos House":
                currLocation = erdos
            case "Hallway":
                currLocation = hallway
            case "Erdos Laptop":
                currLocation = laptop
            case "Aliens":
                currLocation = aliens
            case "Entry Room":
                currLocation = entry
            default:
                context.write("You can't move in that direction.")
            }
            context.write(currLocation.description)
        } else {
            context.write("You can't move in that direction.")
        }
    }

    mutating func checkPassword(context: AdventureGameContext) {
        if inputPass == correctPass {
            foundPass = true
            currLocation.item = Key()
        } else {
            foundPass = false
            currLocation.item = GPT()
        }
    }

    mutating func pickUpItem(context: AdventureGameContext) {
        if let item = currLocation.item {
            let keyItem = currLocation.item
            playerItem = Item(name: keyItem.name, description: keyItem.description, isKeyItem: true)
            context.write(keyItem.interact())
            context.write("You picked up: \(item.name)")
        } else {

            context.write("You haven't entered a password yet.")
        }
    }

    mutating func showInventory(context: AdventureGameContext) {
        if let item = playerItem {
            context.write("You are carrying: \(item.name)")
        } else {
            context.write("Your inventory is empty.")
        }
    }

    mutating func useItem(context: AdventureGameContext) {
        if currLocation.name == "Aliens" {
            if let item = playerItem {
                if item.isKeyItem {
                    context.write("You gave the aliens the correct answer! Earth is saved!")
                    context.endGame()
                } else {
                    context.write("You gave the aliens the wrong answer! Earth is doomed!")
                    context.endGame()
                }
            } else {
                context.write("You don't have any items to use.")
            }
        } else {
            context.write("You can't use an item here.")
        }
    }
}

YourGame.display()

