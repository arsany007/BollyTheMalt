Limitation: 
Nodes have to have unique names 
```mermaid 
 flowchart LR 
 
Explosion(Explosion)---> |child| Sprite(Sprite)
style Sprite stroke:#f66,stroke-width:2px
Explosion(Explosion)---> |child| AnimationPlayer(AnimationPlayer)
style AnimationPlayer stroke:#f66,stroke-width:2px
Explosion(Explosion)---> |child| AudioStreamPlayer2D(AudioStreamPlayer2D)
style AudioStreamPlayer2D stroke:#f66,stroke-width:2px
HUD(HUD)---> |child| PanelContainer(PanelContainer)
style PanelContainer stroke:#f66,stroke-width:2px
HUD(HUD)---> |child| ScoreLabel(ScoreLabel)
style ScoreLabel stroke:#f66,stroke-width:2px
HUD(HUD)---> |child| Score(Score)
style Score stroke:#f66,stroke-width:2px
HUD(HUD)---> |child| SelectedIcePoopLabel(SelectedIcePoopLabel)
style SelectedIcePoopLabel stroke:#f66,stroke-width:2px
HUD(HUD)---> |child| SelectedIcePoop(SelectedIcePoop)
style SelectedIcePoop stroke:#f66,stroke-width:2px
HUD(HUD)---> |child| Button(Button)
style Button stroke:#f66,stroke-width:2px
HUD(HUD)---> |child| GameOver(GameOver)
style GameOver stroke:#f66,stroke-width:2px
HUD(HUD)---> |child| AnimationPlayer(AnimationPlayer)
style AnimationPlayer stroke:#f66,stroke-width:2px
HUD(HUD)---> |child| Button2(Button2)
style Button2 stroke:#f66,stroke-width:2px
IcePoop(IcePoop)---> |child| Sprite(Sprite)
style Sprite stroke:#f66,stroke-width:2px
IcePoop(IcePoop)---> |child| Area2D(Area2D)
style Area2D stroke:#f66,stroke-width:2px
Area2D(Area2D)---> |child| CollisionShape2D(CollisionShape2D)
style CollisionShape2D stroke:#f66,stroke-width:2px
Maze(Maze)---> |child| Globals(Globals)
style Globals stroke:#f66,stroke-width:2px
Maze(Maze)---> |child| TileMap(TileMap)
style TileMap stroke:#f66,stroke-width:2px
Maze(Maze)---> |child| PlayerKini(PlayerKini)
style PlayerKini stroke:#f66,stroke-width:2px
Maze(Maze)---> |child| IcePoop(IcePoop)
style IcePoop stroke:#f66,stroke-width:2px
Maze(Maze)---> |child| SelectIcePoop(SelectIcePoop)
style SelectIcePoop stroke:#f66,stroke-width:2px
SelectIcePoop(SelectIcePoop)---> |child| HUD(HUD)
style HUD stroke:#f66,stroke-width:2px
SelectIcePoop(SelectIcePoop)---> |child| EatSound(EatSound)
style EatSound stroke:#f66,stroke-width:2px
PlayerKini(PlayerKini)---> |child| AnimatedSprite(AnimatedSprite)
style AnimatedSprite stroke:#f66,stroke-width:2px
PlayerKini(PlayerKini)---> |child| CollisionShape2D(CollisionShape2D)
style CollisionShape2D stroke:#f66,stroke-width:2px
PlayerKini(PlayerKini)---> |child| AnimationPlayer(AnimationPlayer)
style AnimationPlayer stroke:#f66,stroke-width:2px
Maze(Maze)---> |child| Icepoop_instance(Icepoop_instance)
style Icepoop_instance stroke:#f66,stroke-width:2px,color:#fff,stroke-dasharray: 5 5
Maze(Maze)---> |child| explode(explode)
style explode stroke:#f66,stroke-width:2px,color:#fff,stroke-dasharray: 5 5
Maze(Maze)---> |child| explode(explode)
style explode stroke:#f66,stroke-width:2px,color:#fff,stroke-dasharray: 5 5
Button(Button)-.-> |_on_Button_pressed| HUD(HUD)

Button2(Button2)-.-> |_on_Button2_pressed| HUD(HUD)

Area2D(Area2D)-.-> |_on_Area2D_body_entered| IcePoop(IcePoop)

TileMap(TileMap)-.-> |_on_TileMap_signal_rotate_cell| Maze(Maze)

PlayerKini(PlayerKini)-.-> |_on_PlayerKini_ice_poop_hit| SelectIcePoop(SelectIcePoop)

SelectIcePoop(SelectIcePoop)-.-> |_on_SelectIcePoop_Game_Over| Maze(Maze)

HUD(HUD)-.-> |_on_HUD_Game_Over| Maze(Maze)

HUD(HUD)-.-> |_on_HUD_New_Game| Maze(Maze)

HUD(HUD)-.-> |_on_HUD_New_Game| SelectIcePoop(SelectIcePoop)

```