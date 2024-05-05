extends Node2D


func play_idle_animation():
	%AnimationPlayer.speed_scale = 1
	%AnimationPlayer.play("idle")


func play_walk_animation():
	%AnimationPlayer.speed_scale = 1
	%AnimationPlayer.play("walk")

func play_dead():
	%AnimationPlayer.speed_scale = 0
