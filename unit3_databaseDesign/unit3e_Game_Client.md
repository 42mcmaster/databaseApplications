# Unit 3e Client Brief — Game Studio

**Client:** Lantern Forge Games, a small studio that makes an online fantasy game called *Emberfall Online*.

*(The studio, the game, and all the data are made up.)*

---

## What the client told us

> "We started tracking everything in one spreadsheet when we only had a few players. Each row is one character. The game server exports it every night.
>
> Now it's a mess. When a player changes their email, we have to find every one of their characters and change it on each row, and we miss some. When we rebalanced the Warrior class, we had to edit every Warrior's row. The inventory column is a long list, so we can't answer simple questions like 'how many players own a Dragonscale Shield?'
>
> We need a real database."

---

## What they keep track of

**Players.** Each player has one account with a username, an email, a country, and the date they joined. A player can make more than one character.

**Characters.** Each character has a name and a level, and belongs to one player. The server gives every character an ID number. Character names don't have to be unique, so two players can both have a character named "Shadow."

**Classes.** Every character is one class: Warrior, Ranger, Mage, Rogue, or Cleric. Each class has a **role** (Tank, Damage, or Healer) and a **base health** number. Every Warrior has the same base health, and every Mage has the same base health.

**Items.** The game has 15 items. Each item has a type (Weapon, Armor, Potion, Material), a rarity (Common, Uncommon, Rare, Epic), and a gold value.

**Inventory.** Each character carries some items, and a quantity of each. "Thorne has 6 Health Potions." Many characters can carry the same kind of item.

---

## What the database needs to do

The studio wants to be able to:

1. Change a player's email **once** and have it be right for all their characters.
2. Change a class's base health **once** and have it apply to every character of that class.
3. Change an item's gold value **once**.
4. Answer questions like "which characters are carrying a Phoenix Feather, and how many?"
5. Add a new class or a new item later without breaking anything.

---

## Your head start

Your design should end up with these **five tables**:

| Table | One row = |
|---|---|
| PLAYERS | one player account |
| CLASSES | one character class |
| CHARACTERS | one character |
| ITEMS | one kind of item |
| INVENTORY | one item that one character is carrying |

**You decide:** which columns go in each table, what each table's primary key is, where the foreign keys go, and which relationships are one-to-many or many-to-many.

---

## Files

- **Spreadsheet:** `datasets/unit3e_Game.xlsx` — tabs `Client_Export`, `1NF`, then one tab per table
- **Turn-in:** `unit3e_Game_lastname.md`
