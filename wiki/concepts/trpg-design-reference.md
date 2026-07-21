---
title: "TRPG Design & Engineering Reference"
type: concept
status: active
created: 2026-07-20
updated: 2026-07-20
verified: 2026-07-20
tags: [game-design, trpg, tactics-ogre, fft, godot, engine-architecture]
sources:
  - "Wikipedia: Tactics Ogre: Let Us Cling Together (1995)"
  - "Wikipedia: Tactics Ogre: Let Us Cling Together (2010 PSP remake)"
  - "Wikipedia: Final Fantasy Tactics"
  - "Wikipedia: Tactical role-playing game (genre article)"
  - "Wikipedia: Fire Emblem: The Binding Blade"
  - "Wikipedia: Disgaea: Hour of Darkness"
  - "Wikipedia: Tactics Ogre: The Knight of Lodis"
  - "Wikipedia: A* search algorithm"
  - "Wikipedia: Behavior tree (AI)"
  - "Wikipedia: Finite-state machine"
paths:
  - "F:/AI/brain/wiki/concepts/trpg-design-reference.md"
---

# TRPG Design & Engineering Reference

A comprehensive reference for building a complete tactical RPG in the tradition of
Tactics Ogre (1995) and Final Fantasy Tactics (1997), targeting Godot 4.

---

## 1. Core TRPG Design Pillars

### 1.1 Grid Types

| Grid Type | Neighbors | Movement Symmetry | Used By | Pros | Cons |
|-----------|-----------|-------------------|---------|------|------|
| **Square (4-dir)** | 4 (N/S/E/W) | Diagonal costs √2× or blocked | FFT, Disgaea, Tactics Ogre | Simple pathfinding, easy tile art, natural for isometric rendering | Diagonal movement ambiguity |
| **Square (8-dir)** | 8 (incl. diagonals) | Uniform if diagonal cost = 1 | Some PC TRPGs | Faster traversal, more fluid | Diagonal "corner cutting" through walls |
| **Hexagonal** | 6 | All neighbors equidistant | Fire Emblem (GBA era uses square, but hex appears in some entries), Battle for Wesnoth, Master of Monsters | No diagonal ambiguity, natural for wargames, 6 directions feel organic | Harder isometric rendering, less natural for building/room layouts |
| **Isometric (diamond)** | 4 or 8 | Visual rotation of square grid | Tactics Ogre, FFT | Depth perception, height reads naturally, "quarter-view" aesthetic | Coordinate math slightly more complex, click detection harder |

**Key insight from the genre:** Tactics Ogre and FFT both use a **square grid rendered
isometrically** — the underlying data structure is a simple 2D array, but the rendering
projects it at a 2:1 diamond ratio. The "isometric" look is purely visual; the logic is
square-grid. This is the recommended approach for a Godot 4 TRPG.

**Concrete numbers from the classics:**
- FFT battle maps: typically 12×12 to 20×20 tiles (compact "diorama-style" levels chosen
  to maintain 60fps on PS1 hardware — a deliberate design constraint that also kept
  battles personal and narrative-focused)
- Tactics Ogre: similar scale, ~15×15 to 25×25 tiles
- Fire Emblem: larger maps, 20×20 to 40×30, but top-down not isometric
- Disgaea: ~16×16 to 20×20, square grid, no height

### 1.2 Movement Costs & Terrain Effects

**Terrain cost table (FFT-style model):**

| Terrain | Base Cost | Notes |
|---------|-----------|-------|
| Plain/Grass | 1 | Baseline |
| Road | 1 | Sometimes 0.5 (halved) |
| Forest | 2 | +Defense bonus (typically +10-20% evasion) |
| Mountain | 3-4 | Impassable for cavalry/mounted units |
| Water (shallow) | 2 | Some classes immune to penalty |
| Water (deep) | Impassable | Unless flying or swimming class |
| Swamp | 2-3 | May inflict status (Poison) |
| Lava | Impassable | Or extreme damage |
| Wall/Cliff | Impassable | Unless flight |
| Bridge | 1 | Structural — can be destroyed |

**Height/Elevation (critical for Tactics Ogre / FFT feel):**
- FFT: Height modifies attack range and damage. Melee attacks from higher ground get a
  bonus; ranged attacks have their range modified by height difference.
  - Height difference formula (FFT): effective range = weapon_range + (attacker_height - target_height)
  - Damage modifier: +1 damage per height level advantage (melee)
- Tactics Ogre: Height affects movement cost (climbing costs more WT), attack accuracy,
  and spell area-of-effect. Units on higher ground have accuracy/evasion advantages.
- Tactics Ogre: Knight of Lodis: "Terrain levels range from basic dirt and grass, to water
  (in varying depths and types), to impassable terrain, such as lava or blank space."
  Movement type (walking, swimming, flying) is class-determined.

**Movement cost formula for pathfinding:**
```
tile_cost = base_terrain_cost
          + height_penalty * abs(height_diff)  // climbing costs extra
          + weather_modifier                    // rain slows, snow slows
          * class_terrain_affinity              // flyers ignore terrain, swimmers prefer water
```

### 1.3 Turn Systems

#### CTB — Charge Time Battle (FFT)

The defining system of Final Fantasy Tactics. Designed by Hiroyuki Ito, who "disliked
tactical RPGs of the time, growing bored with their mechanics, so designed the battle
system to be engaging and feel fast and exciting."

**How it works:**
- Each unit has a **Charge Time (CT)** counter, starting at 0.
- Every "CT tick" (a global time unit), each unit's CT increases by its **Speed** stat.
- When CT ≥ 100, the unit can act. After acting, CT resets (to 0, or carries overflow).
- Turn order is therefore **speed-based initiative** — faster units act more often.
- A unit with Speed 10 acts every 10 ticks. Speed 20 acts every 5 ticks (twice as often).

**Concrete numbers (FFT):**
- Speed stat range: ~5 (slow monsters) to ~15+ (fast units like Ninjas/Thieves)
- CT threshold: 100
- Haste status: +Speed (effectively more frequent turns)
- Slow status: -Speed
- Some abilities have a "charge time" of their own (e.g., powerful spells require
  additional CT to build up before casting — the unit announces the spell, then it fires
  after N more CT ticks, during which the unit can be interrupted)

**Design implications:**
- Speed is the most impactful stat — it determines action frequency, not just turn order
- Creates natural "double turns" for fast units vs slow units
- Charge-time abilities create a prediction/interception mini-game
- No "rounds" — the timeline is continuous, which feels more dynamic than IGOUGO

#### IGOUGO — "I Go, You Go" (Fire Emblem, Tactics Ogre original)

**Tactics Ogre's "Non-Alternate Turn System":**
- Turn order dictated by **Wait Turn (WT)** points
- WT fluctuates based on action type taken (attacking costs more WT than waiting)
- Unit weight and agility impact WT gain per turn
- All units on one side act, then all units on the other side act (phase-based)
- Within a phase, order is determined by WT/agility

**Fire Emblem model:**
- Strict player phase → enemy phase
- Within each phase, units act in any order the player chooses
- No speed-based initiative within a phase
- Simpler to implement, easier for player to plan

#### Speed-Based Initiative (Hybrid)

Many modern TRPGs (Divinity: Original Sin 2, Baldur's Gate 3) use a global initiative
order where all units (player and enemy) are interleaved on a single timeline sorted by
speed/initiative roll. This is closest to FFT's CTB but with discrete rounds.

**Recommendation for a first TRPG:** Start with CTB (FFT-style). It's the most engaging
for the player, creates natural tension, and is straightforward to implement as a priority
queue. The "charge time" mechanic for spells adds depth without adding UI complexity.

### 1.4 Class/Job Systems & Skill Inheritance

#### FFT Job System (the gold standard)

**Structure:**
- 20 jobs accessible by normal characters
- Base classes: **Squire** (warrior path) and **Chemist** (mage path)
- Job tree: Squire → Knight/Archer → Priest/Wizard → ... → advanced jobs
- Unlock condition: reach Job Level N in prerequisite class
  - Example: Chemist Job Level 2 → unlocks Priest and Wizard
- Each job has: innate skill (always active), learnable abilities (bought with JP)

**Skill inheritance (the key innovation):**
- A unit in Job X always has Job X's innate skill
- **Second skill slot**: equip any learned skill from any other job
- **Reaction slot**: equip any learned reaction ability (e.g., "Counter" from Monk)
- **Support slot**: equip any learned support ability (e.g., "+Attack" from Knight)
- **Movement slot**: equip any learned movement ability (e.g., "Move+1" from Thief)

This creates combinatorial depth: a Wizard with Counter, +Attack, and Move+1 is a
completely different unit than a Wizard with Auto-Potion, +Magic, and Teleport.

**JP (Job Points) economy:**
- Earned by performing actions in battle (attacking, casting, healing)
- Spent to learn abilities within current job
- Accumulating enough JP levels up the job (Job Level 1-8)
- Mastering a job (learning all abilities) gives permanent stat bonuses

**Concrete numbers:**
- Abilities per job: 4-12 learnable + 1 innate
- JP cost per ability: 50-1000 JP (basic → advanced)
- Job Level thresholds: ~100 JP per level, 8 levels to master
- Total jobs: 20 (including secret/special jobs)

#### Tactics Ogre Class System

- Classes have dedicated abilities that "can be evolved into more powerful classes through
  use in battle and transferred to compatible characters"
- PSP remake: class system reworked to be **unit-independent** — classes are not locked to
  specific characters, allowing continued use after a unit's death
- Alignment (Law/Neutral/Chaos) affects which classes are available
- Elemental affinity impacts unit compatibility and enhances attacks

#### Tactics Ogre: Knight of Lodis Class System

- Three stats only: Strength, Intelligence, Agility
- Alignment: Chaotic to Lawful
- Element: four classical elements
- **Emblems**: certificates earned by performing specific feats; some alter stats, some
  required for class advancement
- Human classes are interchangeable; demi-humans, dragons, undead cannot change class
- Class requirements: specific stat thresholds + sometimes an emblem + sometimes sex-locked
- Dragon class changes: automatic at stat checkpoints, determined by alignment

#### Fire Emblem Class System

- Fixed class per character (no job switching in classic entries)
- Class determines: movement range, weapon types, strengths/weaknesses
- **Promotion**: using special items, a unit promotes to Advanced Class (stat boost + new abilities)
- **Weapon Triangle**: Axes > Lances > Swords > Axes (rock-paper-scissors)
- **Support System**: adjacent allies gain stat boosts over time (relationship mechanic)
- **Permanent death**: fallen units are gone forever (high stakes)

### 1.5 Unit Progression

**FFT model:**
- **EXP**: earned by performing actions → levels up character (increases base stats)
- **JP**: earned by performing actions → spent on job abilities
- **Job Level**: increases within current job → unlocks new jobs
- Stats grow on level-up based on current job's growth rates
  - Knight: high HP/Attack growth, low Magic
  - Wizard: low HP, high Magic/Speed
- Equipment provides flat stat bonuses

**Tactics Ogre model:**
- EXP raises character level
- Class level increases through use in battle
- Tarot cards (random drops from enemies) provide temporary stat boosts
- Equipment + class + alignment + element all contribute to final stats

**Disgaea model (extreme progression):**
- Level cap: 9999
- Stats can reach millions
- Item World: enter items to level them up
- Reincarnation: reset to level 1 with bonus stat points
- Geo Panel system: map-altering environmental effects

### 1.6 Win/Lose Conditions Beyond "Kill All Enemies"

| Condition Type | Example | Design Purpose |
|---------------|---------|----------------|
| **Kill all enemies** | Default FFT/TO | Baseline |
| **Kill boss/target** | Fire Emblem: "seize the boss's location" | Focuses the battle |
| **Survive N turns** | Defense missions | Tests durability, changes pacing |
| **Protect NPC/ally** | Escort missions | Creates tension, limits player aggression |
| **Reach location** | "Get unit X to tile Y" | Race/stealth feel |
| **Capture/Recruit** | Tactics Ogre "Persuade" mechanic | Non-lethal victory path |
| **Steal item / retrieve object** | Heist missions | Objectives beyond combat |
| **Hold positions** | Control N zones for M turns | Territory control |
| **Lose condition: protagonist dies** | FFT (Ramza dies = game over), TO (Denim dies) | Creates vulnerability despite large party |
| **Turn limit** | Fail if not completed in N turns | Prevents turtling |
| **No allies die** | Fire Emblem "no deaths" challenge | Permadeath raises stakes |

**Tactics Ogre specific:** "An ability unique to the lead character is 'Persuade', which
has a chance of recruiting enemy units in battle." This creates a win condition that's
about recruitment, not destruction.

---

## 2. Tactics Ogre Specific Design

### 2.1 The World Tarot Branching Narrative

**Structure (from the 1995 original and 2010 PSP remake):**

The narrative branches based on **Law / Neutral / Chaos** alignment choices:

- **Branch point**: Chapter 2 — Denim is ordered to participate in the massacre of a town
  (Baramus) that refuses to join the resistance. The player chooses to **accept** (Law)
  or **refuse** (Chaos). Neutral is a middle path.
- **Consequences**:
  - Characters join or leave based on the choice
  - Vice (childhood friend) opposes Denim regardless, but the nature of the opposition differs
  - Kachua (sister) may commit suicide if Denim doesn't comfort her (route-dependent)
  - Different battles, different allies, different story beats in Chapters 2-3
- **Convergence**: Chapter 4 events come back together regardless of route
- **Endings**: Up to **8 different ending variations** based on accumulated choices
- **Warren Report**: A lore database tracking character biographies and events from
  cutscenes — functions as both worldbuilding and a record of the player's specific timeline

**PSP Remake — The World System:**
- Accessed through the Warren Report after completing the campaign once
- Allows the player to **enter decision points in the narrative and play through alternate
  routes without starting the game over**
- Functions as a "chapter select" that preserves your army/progress
- Themed after the Major Arcana tarot card "The World"
- DLC scenarios added post-release covering Warren, Hamilton, and the hometown attack

**Design lesson:** The branching is **narrow but deep** — only 2-3 major branch points,
but each one fundamentally changes the cast, the battles, and the emotional arc. This is
far more manageable than a fully branching tree. The convergence in Chapter 4 means you
only need to author ~1.5× the content of a linear story, not 3×.

### 2.2 Law / Neutral / Chaos Alignment

- Determined initially by **a series of questions** at game start (PSP remake uses Major
  Arcana tarot cards — each answer grants 5 of 22 randomly selected tarots that impact
  starting stats)
- Alignment affects:
  - Which classes are available
  - Which characters join/leave
  - Story branch taken
  - Elemental affinity interactions
  - Ending variations
- **Not a morality meter** — it's a narrative routing mechanism. "Law" means following
  authority; "Chaos" means rejecting it. Neither is "good" or "evil."

**Hidden faction reputation system (original game):**
- A hidden algorithm tracked how different factions viewed Denim
- This determined ending variations when Denim became king
- A cheat existed to view it through the Warren Report screen
- Matsuno lost the memo describing the cheat; it was only found by fans in 2014 through
  data mining
- This is essentially a **reputation system** operating beneath the visible alignment

### 2.3 Unit Loyalty and Morale

- Matsuno "originally planned for more divergence in the story paths, but memory
  limitations meant these and other systems relating to unit loyalty were trimmed down"
- In the original, unit behavior is "influenced by their alignment to the story path"
- The loyalty system was planned to be deeper but was cut — a cautionary tale about scope
- In the PSP remake, the class system was made unit-independent partly to reduce the
  emotional cost of losing units (if a unit dies, their class progress isn't lost)

### 2.4 The CHARIOT Rewind System (PSP Remake, 2010)

**What it is:**
- Records the player's progress up to **50 turns back**
- Allows undoing up to 50 moves and redoing that section of battle
- Themed after the Chariot tarot card
- Added at Matsuno's suggestion during the second half of production

**Anti-exploit design:**
- "The gameplay was adjusted so there was a **random element that would alter the actions
  of enemies**, preventing players from exploiting the system"
- This also carried over to save states — reloading a save produces different enemy behavior
- Originally planned for 100 turns of rewind, reduced to 50 as "too generous"
- Designed as "a tool for beginners" but available to all players

**Implementation implications:**
- Requires storing a **snapshot of full battle state** every turn (unit positions, HP,
  status effects, CT values, RNG seed)
- 50 snapshots × ~20 units × ~20 fields per unit = manageable memory
- The "random element on rewind" means you can't just restore the RNG seed — you must
  **re-seed** the RNG on rewind so enemy AI makes different choices
- This is essentially a **deterministic replay system with controlled divergence**

### 2.5 How Tactics Ogre Differs from FFT Mechanically

| Aspect | Tactics Ogre (1995) | Final Fantasy Tactics (1997) |
|--------|--------------------|-----------------------------|
| **Turn system** | Non-Alternate Turn System (WT-based, phase-based) | CTB (speed-based continuous timeline) |
| **Grid** | Square, isometric, with height | Square, isometric, with height |
| **Camera** | Fixed overhead diagonal (quarter-view) | Freely rotatable + zoomable 3D camera |
| **Class system** | Class tied to unit, alignment-gated | Job system: any unit can be any job, skill inheritance across jobs |
| **Magic** | Charges from empty over battle time (represents "great power of magic") | MP-based (traditional FF) with some charge-time spells |
| **Narrative** | Branching (L/N/C), 8 endings, World Tarot | Linear epic (class conflict theme), single ending |
| **Unit death** | Permadeath for story characters; Denim death = game over | Generic units permadeath; Ramza death = game over |
| **Recruitment** | "Persuade" ability (chance-based mid-battle recruitment) | Buy from Soldier Office; some story recruits |
| **Scale** | Army-based simulation feel | Individual character growth focus |
| **Weather** | Affects gameplay (changes daily on world map) | Affects gameplay (terrain + weather modifiers) |
| **Multiplayer** | Training mode (SFC: 2-player) | PSP: download other player teams, AI-controlled arena |
| **Progression** | Level + Class level + Tarot cards | Level + JP + Job Level + Equipment |
| **Unique mechanic** | Persuade, alignment system, Warren Report | Brave/Faith system, skill inheritance, CTB |

**Matsuno's own words on the difference:** "For the final game [FFT], Matsuno aimed for a
tactical RPG that would be accessible... he placed a focus on individual character growth
similar to the main series, contrasting against the army-based simulation of Tactics Ogre
while keeping its chess-inspired gameplay."

---

## 3. Technical Architecture for a TRPG Engine (Godot 4)

### 3.1 Grid/Map Data Structures

**Recommended: 2D array of TileData resources**

```gdscript
# tile_data.gd
class_name TileData
extends Resource

@export var terrain_type: TerrainType  # enum: PLAIN, FOREST, MOUNTAIN, WATER, etc.
@export var height: int = 0            # elevation level (0-10 typical)
@export var movement_cost: float = 1.0
@export var defense_bonus: float = 0.0
@export var evasion_bonus: float = 0.0
@export var is_passable: bool = true
@export var occupant: Unit = null      # reference to unit on this tile
@export var grid_position: Vector2i    # (x, y) in grid coordinates
```

```gdscript
# battle_grid.gd
class_name BattleGrid
extends Node2D

var width: int = 16
var height: int = 16
var tiles: Array[Array] = []  # 2D array of TileData

func _ready():
    tiles.resize(height)
    for y in height:
        tiles[y] = []
        tiles[y].resize(width)
        for x in width:
            tiles[y][x] = TileData.new()
            tiles[y][x].grid_position = Vector2i(x, y)

func get_tile(pos: Vector2i) -> TileData:
    if pos.x >= 0 and pos.x < width and pos.y >= 0 and pos.y < height:
        return tiles[pos.y][pos.x]
    return null

func get_neighbors(pos: Vector2i, include_diagonal: bool = false) -> Array[TileData]:
    var result: Array[TileData] = []
    var dirs = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
    if include_diagonal:
        dirs += [Vector2i(1,1), Vector2i(1,-1), Vector2i(-1,1), Vector2i(-1,-1)]
    for dir in dirs:
        var tile = get_tile(pos + dir)
        if tile and tile.is_passable:
            result.append(tile)
    return result

# Isometric conversion: grid (x,y) → screen position
func grid_to_screen(grid_pos: Vector2i, tile_size: Vector2 = Vector2(64, 32)) -> Vector2:
    return Vector2(
        (grid_pos.x - grid_pos.y) * tile_size.x / 2.0,
        (grid_pos.x + grid_pos.y) * tile_size.y / 2.0 - grid_pos.y * HEIGHT_STEP
    )
```

**Height rendering:** Each height level offsets the tile's Y position by a fixed pixel
amount (e.g., 8-16px per level). Tactics Ogre used the "Hermit" custom technology to
"create large-scale levels based on positional data using a small amount of system memory."
In Godot 4, this is trivial — just offset the sprite position and use z-index for draw order.

**Map serialization:** Export maps as Godot Resources (.tres) or JSON. Store:
- Grid dimensions
- Per-tile: terrain enum, height, passability, special flags
- Spawn points for player/enemy units
- Victory/defeat condition triggers
- Optional: scripted events (reinforcements at turn N, terrain destruction)

### 3.2 Pathfinding (A* with Terrain Costs)

**A* is the standard for TRPG pathfinding.** It finds the optimal path considering
variable movement costs (terrain, height, obstacles).

```gdscript
# pathfinding.gd
class_name GridPathfinder

var grid: BattleGrid

func find_path(start: Vector2i, goal: Vector2i, max_cost: float,
               unit: Unit) -> Array[Vector2i]:
    var open_set: Array = []  # priority queue: [f_cost, tile_pos]
    var came_from: Dictionary = {}
    var g_score: Dictionary = {start: 0.0}
    var f_score: Dictionary = {start: heuristic(start, goal)}

    open_set.append([f_score[start], start])

    while not open_set.is_empty():
        open_set.sort_custom(func(a, b): return a[0] < b[0])
        var current = open_set.pop_front()[1]

        if current == goal:
            return reconstruct_path(came_from, current)

        for neighbor_tile in grid.get_neighbors(current):
            var neighbor = neighbor_tile.grid_position
            var move_cost = get_movement_cost(neighbor_tile, unit)
            var tentative_g = g_score[current] + move_cost

            if tentative_g > max_cost:
                continue  # exceeds unit's movement range

            if tentative_g < g_score.get(neighbor, INF):
                came_from[neighbor] = current
                g_score[neighbor] = tentative_g
                f_score[neighbor] = tentative_g + heuristic(neighbor, goal)
                if not open_set.any(func(e): return e[1] == neighbor):
                    open_set.append([f_score[neighbor], neighbor])

    return []  # no path found

func heuristic(a: Vector2i, b: Vector2i) -> float:
    # Manhattan distance for 4-dir grid
    return abs(a.x - b.x) + abs(a.y - b.y)

func get_movement_cost(tile: TileData, unit: Unit) -> float:
    var cost = tile.movement_cost
    # Height penalty
    var height_diff = abs(tile.height - grid.get_tile(tile.grid_position).height)
    cost += height_diff * 0.5
    # Class-specific modifiers
    if unit.movement_type == MovementType.FLYING:
        cost = 1.0  # flyers ignore terrain
    elif unit.movement_type == MovementType.SWIMMING and tile.terrain_type == TerrainType.WATER:
        cost = 1.0  # swimmers prefer water
    # Weather modifier
    cost *= get_weather_modifier(tile)
    return cost

func reconstruct_path(came_from: Dictionary, current: Vector2i) -> Array[Vector2i]:
    var path: Array[Vector2i] = [current]
    while current in came_from:
        current = came_from[current]
        path.push_front(current)
    return path
```

**Movement range visualization:** Run a modified Dijkstra (BFS with costs) from the
unit's position up to their movement stat. Highlight all reachable tiles. This is what
the player sees as the "blue movement range" overlay.

```gdscript
func get_reachable_tiles(start: Vector2i, max_cost: float, unit: Unit) -> Array[Vector2i]:
    var reachable: Array[Vector2i] = []
    var dist: Dictionary = {start: 0.0}
    var queue: Array = [[0.0, start]]

    while not queue.is_empty():
        queue.sort_custom(func(a, b): return a[0] < b[0])
        var current = queue.pop_front()[1]
        var current_cost = dist[current]

        for neighbor_tile in grid.get_neighbors(current):
            var n_pos = neighbor_tile.grid_position
            var move_cost = get_movement_cost(neighbor_tile, unit)
            var new_cost = current_cost + move_cost

            if new_cost <= max_cost and new_cost < dist.get(n_pos, INF):
                if neighbor_tile.occupant == null or neighbor_tile.occupant.team == unit.team:
                    dist[n_pos] = new_cost
                    reachable.append(n_pos)
                    queue.append([new_cost, n_pos])

    return reachable
```

**Performance note:** For a 20×20 grid (400 tiles), A* runs in microseconds. Even
running it for every unit on every turn (for AI) is trivial. No optimization needed
until you hit 100×100+ grids, which TRPGs never do.

### 3.3 Turn/State Machine Architecture

**The battle is a finite-state machine.** This is the backbone of the entire combat system.

```
BattleStateMachine states:
├── BATTLE_START        → initialize units, roll initiative, show intro
├── TURN_START          → determine next acting unit (CTB: highest CT)
├── UNIT_SELECT         → highlight acting unit, show options
├── MOVE_SELECT         → show movement range, await player input
├── MOVE_EXECUTE        → animate movement along path
├── ACTION_SELECT       → show action menu (Attack, Skill, Item, Wait)
├── TARGET_SELECT       → show valid targets/range, await selection
├── ACTION_EXECUTE      → calculate damage, apply effects, animate
├── ACTION_RESOLVE      → check for deaths, status effects, triggers
├── TURN_END            → decrement CT, check win/lose conditions
├── ENEMY_TURN          → AI decision-making (same sub-states, AI-driven)
├── BATTLE_WON          → victory sequence, rewards
├── BATTLE_LOST         → defeat sequence, game over / retry
└── BATTLE_PAUSED       → menu, save, CHARIOT rewind
```

**Godot 4 implementation:**

```gdscript
# battle_state_machine.gd
class_name BattleStateMachine
extends Node

signal state_changed(new_state: BattleState)

enum BattleState {
    BATTLE_START, TURN_START, UNIT_SELECT, MOVE_SELECT,
    MOVE_EXECUTE, ACTION_SELECT, TARGET_SELECT,
    ACTION_EXECUTE, ACTION_RESOLVE, TURN_END,
    ENEMY_TURN, BATTLE_WON, BATTLE_LOST, BATTLE_PAUSED
}

var current_state: BattleState = BattleState.BATTLE_START
var battle_manager: BattleManager

func transition_to(new_state: BattleState) -> void:
    var old = current_state
    current_state = new_state
    state_changed.emit(new_state)
    _on_state_enter(new_state)

func _on_state_enter(state: BattleState) -> void:
    match state:
        BattleState.TURN_START:
            battle_manager.advance_ct()
            var next_unit = battle_manager.get_next_actor()
            if next_unit.is_player_controlled:
                transition_to(BattleState.UNIT_SELECT)
            else:
                transition_to(BattleState.ENEMY_TURN)
        BattleState.ACTION_RESOLVE:
            battle_manager.check_deaths()
            if battle_manager.check_victory():
                transition_to(BattleState.BATTLE_WON)
            elif battle_manager.check_defeat():
                transition_to(BattleState.BATTLE_LOST)
            else:
                transition_to(BattleState.TURN_END)
        # ... etc
```

**CTB Turn Manager:**

```gdscript
# ct_manager.gd
class_name CTManager

const CT_THRESHOLD: float = 100.0
var units: Array[Unit] = []

func advance_tick() -> Unit:
    # Increment all units' CT by their speed
    for unit in units:
        if unit.is_alive:
            unit.ct += unit.get_effective_speed()

    # Find all units ready to act (CT >= 100)
    var ready = units.filter(func(u): return u.is_alive and u.ct >= CT_THRESHOLD)
    if ready.is_empty():
        return advance_tick()  # recurse until someone is ready

    # Sort by CT descending (highest CT acts first)
    ready.sort_custom(func(a, b): return a.ct > b.ct)
    var actor = ready[0]
    actor.ct -= CT_THRESHOLD  # consume the turn (carry overflow)
    return actor
```

### 3.4 Enemy AI

**TRPG AI needs three layers:**

#### Layer 1: Threat Evaluation (who to target)

```gdscript
func evaluate_threat(ai_unit: Unit, target: Unit) -> float:
    var score: float = 0.0

    # Can we kill them this turn?
    var predicted_damage = calculate_damage(ai_unit, target)
    if predicted_damage >= target.current_hp:
        score += 100.0  # kill priority

    # How much damage can we deal?
    score += predicted_damage * 0.5

    # Are they a healer? Prioritize healers
    if target.has_healing_ability():
        score += 30.0

    # Are they low HP? (finish them off)
    score += (1.0 - float(target.current_hp) / target.max_hp) * 20.0

    # Are they in range? (don't chase unreachable targets)
    if not is_in_range(ai_unit, target):
        score -= 50.0

    # Terrain advantage (target on high ground is harder to hit)
    score -= get_height_difference(ai_unit, target) * 5.0

    # Proximity (prefer closer targets to reduce movement)
    score -= grid_distance(ai_unit, target) * 2.0

    return score
```

#### Layer 2: Positioning (where to move)

```gdscript
func evaluate_position(ai_unit: Unit, tile: TileData) -> float:
    var score: float = 0.0

    # Height advantage
    score += tile.height * 3.0

    # Terrain defense bonus
    score += tile.defense_bonus * 10.0

    # Distance to best target (want to be in range)
    var best_target = get_best_target(ai_unit)
    if best_target:
        var dist = grid_distance(tile.grid_position, best_target.grid_position)
        if dist <= ai_unit.attack_range:
            score += 20.0  # in range, good
        else:
            score -= dist * 2.0  # penalize being out of range

    # Avoid clustering (don't stack units on same tile area)
    for ally in get_allies(ai_unit):
        if grid_distance(tile.grid_position, ally.grid_position) <= 1:
            score -= 10.0

    # Avoid dangerous tiles (in enemy attack range)
    for enemy in get_enemies(ai_unit):
        if grid_distance(tile.grid_position, enemy.grid_position) <= enemy.attack_range:
            score -= 15.0

    return score
```

#### Layer 3: Action Selection (what to do)

```gdscript
func decide_action(ai_unit: Unit) -> ActionDecision:
    var targets = get_valid_targets(ai_unit)
    if targets.is_empty():
        return ActionDecision.new(ActionType.WAIT)

    # Sort targets by threat score
    targets.sort_custom(func(a, b):
        return evaluate_threat(ai_unit, a) > evaluate_threat(ai_unit, b))

    var best_target = targets[0]
    var threat = evaluate_threat(ai_unit, best_target)

    # If we can kill, always attack
    if threat >= 100.0:
        return ActionDecision.new(ActionType.ATTACK, best_target)

    # If we have a healing ability and an ally is hurt, heal instead
    var hurt_ally = get_most_hurt_ally(ai_unit)
    if hurt_ally and ai_unit.has_healing_ability():
        var heal_value = ai_unit.get_heal_power()
        if hurt_ally.max_hp - hurt_ally.current_hp > heal_value * 0.5:
            return ActionDecision.new(ActionType.HEAL, hurt_ally)

    # Use AoE if it hits 2+ enemies
    var aoe_target = find_best_aoe_position(ai_unit)
    if aoe_target and aoe_target.units_hit >= 2:
        return ActionDecision.new(ActionType.SKILL, aoe_target)

    # Default: attack best target
    return ActionDecision.new(ActionType.ATTACK, best_target)
```

**AI architecture choice:** For a TRPG, a simple **utility-based AI** (scoring functions
as above) is sufficient and much easier to tune than behavior trees. Behavior trees are
better for real-time AI with complex state transitions. TRPG AI is discrete and
turn-based — score each option, pick the best.

**Difficulty scaling:** Adjust AI behavior by:
- Easy: AI ignores positioning, attacks nearest target, doesn't focus-fire
- Normal: AI uses threat evaluation, basic positioning
- Hard: AI uses full threat eval + positioning + focus-fire + ability usage
- Tactics Ogre approach: AI is aggressive and punishes mistakes (no difficulty slider
  in the original; the PSP remake added difficulty options)

### 3.5 Camera Systems for Isometric Views

**FFT's key innovation:** "It also expanded on the isometric grid combat of Tactics Ogre
by allowing players to freely rotate the camera around the battlefield rather than keeping
the camera in a fixed position."

**Tactics Ogre:** Fixed overhead diagonal (quarter-view). The PSP remake added a top-down
view option: "players able to switch between the default overhead diagonal view, and a
top-down view with flattened topography."

**Godot 4 implementation options:**

1. **2D isometric (simpler, recommended for first game):**
   - Use `TileMapLayer` with isometric tile set (tile shape: half-rect, 2:1 ratio)
   - Camera2D with zoom controls
   - Draw order: sort by (x + y + height) for correct overlap
   - Rotation: pre-render 4 rotation states of each tile, swap on camera rotate
   - This is what Tactics Ogre effectively did (fixed angle, no rotation)

2. **3D with orthographic camera (FFT-style):**
   - Use `Camera3D` with `projection = ORTHOGONAL`
   - Angle: ~30-45° from horizontal, looking down
   - Allow Y-axis rotation in 90° increments (4 views)
   - Zoom: adjust camera `size` property
   - Tiles are 3D meshes or `Sprite3D` on a grid
   - Height is actual Y-position in 3D space

**Recommended for Godot 4:** Start with 2D isometric. It's simpler, performs better,
and matches the Tactics Ogre aesthetic. Add camera rotation later if needed.

```gdscript
# isometric_camera.gd
class_name IsometricCamera
extends Camera2D

var zoom_level: float = 1.0
var min_zoom: float = 0.5
var max_zoom: float = 2.0
var pan_speed: float = 400.0

func _unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_WHEEL_UP:
            zoom_level = min(zoom_level * 1.1, max_zoom)
        elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
            zoom_level = max(zoom_level / 1.1, min_zoom)
        zoom = Vector2(zoom_level, zoom_level)
    elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
        position -= event.relative / zoom_level
```

### 3.6 Save/Load for Mid-Battle State

**What needs to be serialized:**

```gdscript
# battle_save_data.gd
class_name BattleSaveData
extends Resource

@export var map_id: String
@export var turn_number: int
@export var ct_values: Dictionary      # unit_id → CT value
@export var unit_states: Array         # Array of UnitSaveData
@export var tile_states: Array         # modified tiles (destroyed terrain, etc.)
@export var rng_seed: int              # for deterministic replay
@export var active_effects: Array      # ongoing status effects with remaining duration
@export var battle_flags: Dictionary   # scripted event triggers already fired
@export var chariot_history: Array     # last N turn snapshots for rewind

# unit_save_data.gd
class_name UnitSaveData
extends Resource

@export var unit_id: String
@export var grid_position: Vector2i
@export var current_hp: int
@export var current_mp: int
@export var ct: float
@export var status_effects: Array[String]
@export var job_id: String
@export var equipped_abilities: Array[String]
@export var is_alive: bool
@export var facing: int  # 0=N, 1=E, 2=S, 3=W
```

**CHARIOT implementation (50-turn rewind):**
- Every turn, push a full `BattleSaveData` snapshot onto a ring buffer of size 50
- On rewind: pop the desired snapshot, restore all state, **re-seed the RNG**
- The re-seed is critical — without it, the player can perfectly predict enemy actions
  after rewinding, which breaks the intended challenge

**Save file format:** Use Godot's `ResourceSaver.save()` for .tres files, or serialize
to JSON for cross-platform compatibility. For a TRPG, save files are small (< 1MB even
with 50 CHARIOT snapshots).

### 3.7 Data-Driven Design for Unit Stats/Skills/Classes

**Use Godot Resources (.tres) for all game data.** This allows designers to edit stats
in the Godot inspector without touching code.

```gdscript
# job_definition.gd
class_name JobDefinition
extends Resource

@export var job_id: String
@export var job_name: String
@export var description: String
@export var prerequisite_job: JobDefinition  # null for base classes
@export var prerequisite_level: int = 0
@export var base_stats: Dictionary  # {"hp": 100, "mp": 20, "attack": 10, ...}
@export var growth_rates: Dictionary  # {"hp": 12, "mp": 3, "attack": 2, ...}
@export var innate_skill: SkillDefinition
@export var learnable_skills: Array[SkillDefinition]
@export var movement: int = 4
@export var movement_type: MovementType
@export var terrain_affinities: Dictionary  # {TerrainType.FOREST: 0.5, ...}

# skill_definition.gd
class_name SkillDefinition
extends Resource

@export var skill_id: String
@export var skill_name: String
@export var skill_type: SkillType  # ATTACK, HEAL, BUFF, DEBUFF, PASSIVE, REACTION
@export var slot_type: SlotType    # INNATE, ACTIVE, REACTION, SUPPORT, MOVEMENT
@export var jp_cost: int = 100
@export var mp_cost: int = 0
@export var ct_cost: float = 0.0   # charge time for powerful spells
@export var range: int = 1
@export var aoe_shape: AoEShape    # SINGLE, CROSS, LINE, SQUARE, DIAMOND
@export var aoe_size: int = 0
@export var power: int = 10
@export var element: ElementType
@export var status_effect: StatusEffect  # null if none
@export var status_chance: float = 0.0
@export var height_affected: bool = true
@export var animation_id: String

# unit_definition.gd
class_name UnitDefinition
extends Resource

@export var unit_id: String
@export var unit_name: String
@export var base_level: int = 1
@export var base_job: JobDefinition
@export var base_stats: Dictionary
@export var brave: int = 50        # FFT-style: affects physical damage
@export var faith: int = 50        # FFT-style: affects magic damage
@export var alignment: Alignment   # LAW, NEUTRAL, CHAOS
@export var element: ElementType
@export var is_story_character: bool = false
@export var portrait: Texture2D
@export var sprite_frames: SpriteFrames
```

**Balance numbers from the classics (for reference):**

| Stat | FFT Range | TO Range | Notes |
|------|-----------|----------|-------|
| HP | 100-999 | 50-500 | Scales with level and job |
| MP | 10-200 | 0-100 | TO: magic charges from 0 |
| Attack | 5-50 | 5-40 | Base + weapon + job modifier |
| Magic | 5-50 | 5-40 | Scales with Faith (FFT) |
| Speed | 5-15 | 5-20 | Determines CT tick rate (FFT) or WT (TO) |
| Brave | 1-100 | N/A | FFT: physical damage multiplier (Brave/100) |
| Faith | 1-100 | N/A | FFT: magic damage multiplier (Faith/100) |
| Movement | 3-6 | 3-8 | Tiles per turn |
| Job Levels | 1-8 | 1-? | 8 levels to master in FFT |
| JP per ability | 50-1000 | N/A | FFT: basic → advanced |

---

## 4. Scope Reality Check

### 4.1 Minimum Viable TRPG

**What you MUST have (the irreducible core):**

1. **Grid + movement + pathfinding** — square grid, A*, terrain costs, height (optional
   for v1 but strongly recommended for the TO/FFT feel)
2. **Turn system** — CTB or IGOUGO, one or the other, working correctly
3. **Combat resolution** — attack, damage formula, HP, death, victory/defeat
4. **3-5 classes** with distinct roles (tank, DPS, healer, ranged, support)
5. **8-12 battle maps** with varied terrain
6. **Basic enemy AI** — target selection, movement toward player, attack
7. **Unit progression** — level up, stat growth, at least 2-3 abilities per class
8. **Win/lose conditions** — kill all enemies + protagonist death = game over
9. **Save/load** — between battles at minimum
10. **UI** — unit stats, ability menu, movement range display, HP bars

**What you can CUT for v1:**

- ❌ Branching narrative (do linear first, add branches in v2)
- ❌ Job switching / skill inheritance (do fixed classes first)
- ❌ CHARIOT rewind (nice-to-have, not essential)
- ❌ Weather system (add later)
- ❌ Status effects beyond Poison/Stun (start with 2-3, expand)
- ❌ Crafting system
- ❌ Multiplayer
- ❌ Monster recruitment / Persuade mechanic
- ❌ More than 2 elements (start with Fire/Ice/Lightning or just Physical/Magic)
- ❌ Cutscenes / voice acting
- ❌ World map exploration (use a simple node-based map like FFT)

### 4.2 What to Cut vs Keep for a First Complete Game

**The "Tactics Ogre Lite" scope (achievable for a solo/small team):**

| Feature | Scope | Time Estimate |
|---------|-------|---------------|
| Grid engine + isometric rendering | 16×16 maps, 3 height levels | 2-3 weeks |
| CTB turn system | Speed-based, CT threshold 100 | 1 week |
| 4 classes (Knight, Archer, Mage, Healer) | 3 abilities each | 2-3 weeks |
| Combat system + damage formulas | Physical + Magic, height modifier | 2 weeks |
| Enemy AI (utility-based) | Target selection + positioning | 2-3 weeks |
| 10 battle maps | Varied terrain, 2-3 with height | 3-4 weeks |
| Linear story (5-8 chapters) | Text dialogue, no branching | 2-3 weeks |
| Unit progression | Level up, stat growth, ability unlock | 1-2 weeks |
| Save/load | Between battles + mid-battle | 1-2 weeks |
| UI/UX | Menus, HUD, ability selection | 3-4 weeks |
| Audio | SFX + music (use asset packs) | 1-2 weeks |
| **Total** | | **~5-7 months** |

**The "FFT Lite" scope (adding job system):**
Add 4-6 weeks for job switching + skill inheritance. This is the single biggest scope
increase but also the single most replayability-increasing feature.

### 4.3 Common TRPG Project Killers

Based on postmortems and the history of the genre:

1. **Scope creep on the class/job system.** FFT had 20 jobs. You do not need 20 jobs.
   Start with 4-6. Matsuno himself "had to push against Ito's wish to simplify the class
   system" — even the pros argued about this. Every additional job multiplies balancing
   work and ability authoring.

2. **Map editor rabbit hole.** Building a custom map editor is a project in itself.
   For a first game, hand-author maps in Tiled or directly in Godot scenes. FFT's
   "compact diorama-style levels" were a deliberate constraint, not a limitation.

3. **AI that's too dumb or too smart.** Dumb AI (walk forward, attack nearest) makes the
   game trivially easy. Perfect AI (always optimal play) makes it frustratingly hard.
   Budget significant time for AI tuning. The utility-based scoring approach above is
   tunable via weights, which is critical.

4. **Balance paralysis.** TRPGs have an enormous parameter space: stats × classes ×
   abilities × terrain × height × elements × status effects. You cannot analytically
   balance this. Playtest early, playtest often, adjust numbers in data files (not code).
   This is why data-driven design (Section 3.7) is non-negotiable.

5. **The "second half" problem.** TRPGs are front-loaded in systems work (grid, turns,
   combat, AI) but back-loaded in content (maps, story, abilities, balancing). Many
   projects have a great combat prototype and never ship because the content pipeline
   (making 15+ interesting maps, writing a story, authoring 30+ abilities) is where the
   real time goes.

6. **Permadeath without save scumming protection.** If you implement permadeath (Fire
   Emblem style), players will save-scum. Either embrace it (FFT: generic units are
   expendable, story characters are protected) or implement the CHARIOT approach
   (controlled rewind with RNG re-seeding).

7. **Ignoring the "between battles" loop.** FFT's world map with shops, bars (sidequests),
   soldier offices (recruitment), and random encounters is what makes the game feel like
   a world, not just a sequence of battles. Budget time for this meta-game layer.

8. **Not playing your own game enough.** Matsuno and Ito playtested FFT extensively;
   "level design and mastering continued until a week before the game shipped." TRPG
   balance cannot be designed on paper — it emerges from play.

### 4.4 Recommended Development Order

```
Phase 1: Core Combat (Month 1-2)
  ├── Grid rendering (isometric, height)
  ├── Unit placement + movement (A* pathfinding)
  ├── CTB turn system
  ├── Basic attack + damage formula
  ├── 2 classes (Knight, Mage) with 1 ability each
  ├── Kill-all-enemies victory condition
  └── 1 test map

Phase 2: Combat Depth (Month 2-3)
  ├── 2 more classes (Archer, Healer)
  ├── 3 abilities per class
  ├── Height/terrain modifiers in combat
  ├── Enemy AI (target selection + positioning)
  ├── Status effects (Poison, Stun)
  ├── 3 battle maps with varied terrain
  └── Basic UI (HP bars, ability menu, movement range)

Phase 3: Progression + Structure (Month 3-4)
  ├── Unit leveling + stat growth
  ├── Ability unlock progression
  ├── Between-battle menu (equip, view stats)
  ├── Save/load (between battles)
  ├── 3 more battle maps
  └── Simple node-based world map

Phase 4: Content + Polish (Month 4-6)
  ├── 4 more battle maps (total: 10)
  ├── Linear story dialogue (5-8 chapters)
  ├── 2 more classes (Thief, Summoner) or job switching
  ├── Mid-battle save
  ├── Sound effects + music
  ├── Victory/defeat screens + rewards
  └── Playtesting + balance pass

Phase 5: Ship (Month 6-7)
  ├── Final balance pass
  ├── Bug fixing
  ├── Options menu (difficulty, speed)
  └── Release
```

---

## Appendix A: Damage Formula Reference

**FFT-style physical damage:**
```
raw_damage = (Attack * Brave/100) - Defense
height_bonus = (attacker_height - target_height)  // +1 per level advantage
final_damage = max(1, raw_damage + height_bonus)
// Modified by: terrain defense bonus, status effects, element
```

**FFT-style magic damage:**
```
raw_damage = (MagicPower * Faith/100) * SpellPower - MagicDefense
final_damage = max(1, raw_damage)
// Modified by: element affinity, status effects
```

**Tactics Ogre-style (simplified):**
```
raw_damage = Attack - Defense
accuracy = base_accuracy + height_bonus - target_evasion - terrain_evasion
if random(100) < accuracy:
    apply raw_damage
// Magic: charges from 0 during battle, no MP cost per se
```

**Critical hit:** Typically 5-15% chance, 1.5× damage. FFT uses Brave stat to influence
critical rate.

## Appendix B: Key Design Quotes from the Creators

- **Matsuno on TO→FFT transition:** "He placed a focus on individual character growth
  similar to the main series, contrasting against the army-based simulation of Tactics
  Ogre while keeping its chess-inspired gameplay."

- **Ito on the CTB system:** "Ito disliked tactical RPGs of the time, growing bored with
  their mechanics, so designed the battle system to be engaging and feel fast and exciting."

- **Matsuno on FFT's class system:** "Matsuno had to push against Ito's wish to simplify
  the class system."

- **Matsuno on TO's branching:** "Matsuno originally planned for more divergence in the
  story paths, but memory limitations meant these and other systems relating to unit
  loyalty were trimmed down."

- **Matsuno on TO's inspiration:** "The battle system was inspired by chess."

- **Matsuno on TO's magic:** "The magic system, which started with an empty magic meter
  that charged over time, was chosen to represent the great power of magic in the game's
  world."

- **On FFT's level design:** "The level design, which used compact diorama-style levels,
  was chosen to allow the intended 60 frames per second... The small scale of battles
  also reinforced the personal nature of the game's narrative conflicts."

- **On the CHARIOT system:** "The Chariot system was meant as a tool for beginners, but
  the gameplay was adjusted so there was a random element that would alter the actions of
  enemies, preventing players from exploiting the system."

- **On the genre's accessibility:** "The resurgence of tactical-isometric RPGs has a lot
  to do with accessibility. Changes in the ecosystem like Steam and digital distribution
  have made it easier than ever for developers to connect with players." — Dan Tudge, n-Space
