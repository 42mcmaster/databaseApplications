# Unit 4 Starting Design — Game Studio (Emberfall Online)

**Use this design for Unit 4**, even if your 3e design was different. Everyone in your client group builds the same tables, so the data files in 4b load without errors.

Compare it with your 3e design. If yours is different, figure out what changed and why.

## Tables

Table names and column names are written exactly as you should type them in SQL.

### players

One row = one player account.

| Column | Key |
|---|---|
| `player_username` | PK |
| `player_email` |  |
| `player_country` |  |
| `player_joined` |  |

### classes

One row = one character class.

| Column | Key |
|---|---|
| `class_name` | PK |
| `class_role` |  |
| `class_base_health` |  |

### items

One row = one kind of item.

| Column | Key |
|---|---|
| `item_name` | PK |
| `item_type` |  |
| `item_rarity` |  |
| `item_gold_value` |  |

### characters

One row = one character.

| Column | Key |
|---|---|
| `character_id` | PK |
| `character_name` |  |
| `level` |  |
| `class_name` | FK → classes |
| `player_username` | FK → players |

### inventory

One row = one item one character carries.

| Column | Key |
|---|---|
| `character_id` | PK, FK → characters |
| `item_name` | PK, FK → items |
| `quantity` |  |

## Relationships

- players → characters: one-to-many
- classes → characters: one-to-many
- characters ↔ items: many-to-many, through inventory

## Create the tables in this order

Parent tables first, because a foreign key can only point at a table that already exists:

`players` → `classes` → `items` → `characters` → `inventory`

## Data files (for 4b)

In 4b you'll import these files from this unit's `datasets/` folder, in this order: `game_players.csv`, `game_classes.csv`, `game_items.csv`, `game_characters.csv`, `game_inventory.csv`.
