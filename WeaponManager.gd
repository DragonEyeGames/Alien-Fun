extends Node

var items = {
	"fireball": {
		"level": 1,
		"stats" : {
			"damage": 5,
			"speed": 2,
			"size": 1.0,
			"count": 1
		},
		"upgrades" : {
			"damage": 1.2,
			"speed": 1.5,
			"size": 1.1,
			"count": 1
		},
		"upgrade_type": {
		"damage": "mul",
		"speed": "mul",
		"size": "mul",
		"count": "add"
		}
	},
	"fist": {
		"level": 1,
		"stats" : {
			"damage": 1,
			"size": .5,
			"count": 5,
		},
		"upgrades" : {
			"damage": 1.2,
			"size": 1.1,
			"count": 2
		},
		"upgrade_type": {
		"damage": "mul",
		"size": "mul",
		"count": "add"
		}
	},
	"player": {
		"level": 1,
		"stats" : {
			"health": 100,
			"speed": 1
		},
		"upgrades" : {
			"health": 1.05,
			"speed": 1.05
		},
		"upgrade_type": {
			"health": "mul",
			"speed": "mul"
		}
	},
}
