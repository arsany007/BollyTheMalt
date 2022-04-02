# BollyTheMalt

## **Drawing the map:**

Tileset value explaination:

->Road open end = 0 <br>
->Road close end = 1 <br>

Read the bits Anti clockwise starting from the left

Example:<br>
The Value for the following TileSet = 1011 = "11.png" <br>

![Example](https://github.com/arsany007/BollyTheMalt/blob/main/road/TileMapExample.jpg?raw=true)

---


```mermaid
flowchart TD

Maze -->|has| PlayerKini
Maze -->|has| IcePoop


subgraph Map
    direction LR
    Maze -->|has| TileMap
end

IcePoop -->|para_hit| PlayerKini
PlayerKini -->|signal_hit,para_icepoop| SelectIcePoop

SelectIcePoop -->|para_score| HUD

```