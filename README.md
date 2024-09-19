# Erdos and Aliens

**Erdos and Aliens** is a text-based adventure game where the player must save Earth from alien destruction by solving the Ramsey number problem. Navigate through different rooms, solve puzzles, and interact with items to save the planet from doom!

---

## Game Overview

**Objective:**  
Aliens have invaded Earth and threaten to obliterate it unless the Ramsey number for red five and blue five is provided. As the player, you must navigate through different rooms, gather information, and find the correct solution before it’s too late.

---

## Locations/Rooms

The game features five key locations that the player must traverse:

1. **Entry Room**: The starting point of your adventure.
2. **Erdos House**: Meet Erdos and learn more about the alien's challenge.
3. **Hallway**: A passage that leads to critical places.
4. **Erdos Laptop**: The location where you must enter the password to retrieve the key.
5. **Aliens**: The final confrontation. Use the correct answer to save Earth or face its destruction.

---

## Items

During the game, players will interact with two key items:

1. **Answer Key**: The correct solution to the Ramsey number problem. This will save Earth.
2. **AI-Generated Solution**: A wrong answer that will lead to Earth's destruction.

---

## Code Design

The game is designed using a combination of Swift `structs`, `enums`, and `protocols`:

- **Structs** are used to represent both `Locations` and `Items`. Each location has a name, description, directions, and an optional item.
- The **`Interactable` protocol** ensures that items like the Answer Key and AI-Generated Solution have a name, description, and an interaction behavior when picked up.
- **Optionals** are used for the `playerItem` (the item the player picks up) and the `currLocation.item` (whether an item is available in the current location).
- Game logic controls player movement, item interaction, and the flow of the narrative based on player input.

---

## Available Commands

### Movement Commands:
- **north**, **south**, **east**, **west**: Move in the specified direction between rooms.

### Interaction Commands:
- **enterpassword [password]**: Enter the password to try and solve the Ramsey number (only usable in the Laptop room).
- **take**: Pick up the item after entering the correct password (only usable in the Laptop room).
- **inventory**: Check the player's inventory to see the item they are carrying.
- **useitem**: Use the item (key or wrong answer) to interact with the aliens (only usable in the Aliens room).
- **look**: Look around the current room for information.
- **help**: List the available commands.

---

## How to Play

1. **Download or Clone the Repository**:  
   Clone this repository to your local machine using:
   ```bash
   git clone https://github.com/yourusername/ErdosAndAliens.git
   ```
2. **Run the Game:**
   Open the project in Xcode (if using the Playground format) and follow the game's instructions to navigate through the world, interact with objects, and solve puzzles.
   
