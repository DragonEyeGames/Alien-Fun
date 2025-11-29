extends Node

var items = {
	"fireball": {
		"level": 1,
		"stats" : {
			"damage": 5,
			"speed": 2,
			"size": 1.0,
			"count": 1
		}
	},

	"shield": {
		"level": 1,
		"max_level": 5,
		"stats": {
			"hp": 100,
			"regen": 1.0
		},
		"upgrades": {
			"hp": 1.30,
			"regen": 1.05
		}
	}
}
