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

M[Maze] -->|has| P[PlayerKini]
M[Maze] -->|has| I[IcePoop]
F[Fathy] 


subgraph Map
    direction LR
    M[Maze] -->|has| TM[TileMap]
end

I -->|para_hit| P
P -->|signal_hit,para_icepoop| S[SelectIcePoop]

S -->|para_score| H[HUD]

```