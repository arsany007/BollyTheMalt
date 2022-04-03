Limitation: 
Nodes have to have unique names 
```mermaid 
 flowchart LR 
 
Explosion---> |child| Sprite
Explosion---> |child| AnimationPlayer
Explosion---> |child| AudioStreamPlayer2D
HUD---> |child| PanelContainer
HUD---> |child| ScoreLabel
HUD---> |child| Score
HUD---> |child| SelectedIcePoopLabel
HUD---> |child| SelectedIcePoop
HUD---> |child| Button
HUD---> |child| GameOver
HUD---> |child| AnimationPlayer
HUD---> |child| Button2
IcePoop---> |child| Sprite
IcePoop---> |child| Area2D
Area2D---> |child| CollisionShape2D
Maze---> |child| Globals
Maze---> |child| TileMap
Maze---> |child| PlayerKini
Maze---> |child| IcePoop
Maze---> |child| SelectIcePoop
SelectIcePoop---> |child| HUD
SelectIcePoop---> |child| EatSound
PlayerKini---> |child| AnimatedSprite
PlayerKini---> |child| CollisionShape2D
PlayerKini---> |child| AnimationPlayer
Button-.-> |_on_Button_pressed| HUD
Button2-.-> |_on_Button2_pressed| HUD
Area2D-.-> |_on_Area2D_body_entered| IcePoop
TileMap-.-> |_on_TileMap_signal_rotate_cell| Maze
PlayerKini-.-> |_on_PlayerKini_ice_poop_hit| SelectIcePoop
SelectIcePoop-.-> |_on_SelectIcePoop_Game_Over| Maze
HUD-.-> |_on_HUD_Game_Over| Maze
HUD-.-> |_on_HUD_New_Game| Maze
HUD-.-> |_on_HUD_New_Game| SelectIcePoop
```