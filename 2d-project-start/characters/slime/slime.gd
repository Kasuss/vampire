extends Node2D


func play_walk():
	%AnimationPlayer.speed_scale = 1
	%AnimationPlayer.play("walk")


func play_hurt():
	%AnimationPlayer.speed_scale = 1
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.queue("walk")
