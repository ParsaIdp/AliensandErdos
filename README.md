# *Erdos and Aliens*

*For instructions, consult the [CIS 1951 website](https://www.seas.upenn.edu/~cis1951/24fa/assignments/hw/hw1).*

## Explanations

**What locations/rooms does your game have?**

1. Entry Room
2. Erdos House
3. Hallway
4. Erdos Laptop
5. Aliens
6. 
7. 
8. 
9. 
10. 

**What items does your game have?**

1. Answer Key
2. AI generated solution

**Explain how your code is designed. In particular, describe how you used structs or enums, as well as protocols.**

The game is designed using several `structs` to represent `Locations` and `Items`. It uses the `Interactable` protocol for items like the "Answer Key" and the "AI-generated solution," which provide custom interactions when picked up. The game world is made of locations, each with their name, description, and possible directions the player can move in. The game logic allows the player to move between these locations, pick up items, and solve a puzzle to save Earth by entering the correct password.

**How do you use optionals in your program?**

Optionals are used for the `playerItem` (to store an item if the player picks one up) and for the `currLocation.item` (to indicate whether an item is available in the current location). These optionals handle scenarios where no item is present.


**What extra credit features did you implement, if any?**

None 

## Endings

### Ending 1 (Win: The player saves Earth by giving the correct answer)

```
north east north enterpassword Kolmogrov take east useitem
```

### Ending 2 (Lose: The player gives the wrong answer and Earth is destroyed)

```
north east north enterpassword wrongpass take east useitem
```

---

## Commands

### Movement Commands:
- **north**, **south**, **east**, **west**: Move in the specified direction between rooms.

### Interaction Commands:
- **enterpassword [password]**: Enter the password to try and solve the Ramsey number (only usable in the Laptop room).
- **take**: Pick up the item after entering the correct password (only usable in the Laptop room).
- **inventory**: Check the player's inventory to see the item they are carrying.
- **useitem**: Use the item (key or wrong answer) to interact with the aliens (only usable in the Aliens room).
- **look**: Look around the current room for information.
- **help**: List the available commands.
