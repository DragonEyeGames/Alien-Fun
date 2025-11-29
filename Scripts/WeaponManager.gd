extends Node

var items = {
	"fireball": {
		"level": 0,
		"description": "I don't care how big the room is",
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
		"level": 0,
		"description": "Express your anger",
		"stats" : {
			"damage": 2,
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
	"lightning": {
		"level": 0,
		"description": "Kerzap",
		"stats" : {
			"damage": 1,
			"size": 1,
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
	"tornado": {
		"level": 0,
		"description": "Blow them away",
		"stats" : {
			"damage": 3,
			"speed": 1.5,
			"size": 1,
			"count": .5,
			"duration": 3
		},
		"upgrades" : {
			"damage": 1.2,
			"size": 1.1,
			"speed": 1.2,
			"count": .5,
			"duration": 1.2
		},
		"upgrade_type": {
		"damage": "mul",
		"speed": "mul",
		"size": "mul",
		"count": "add",
		"duration": "mul"
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
