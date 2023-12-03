extends Node2D

const PART_ONE_RED = 12;
const PART_ONE_GREEN = 13;
const PART_ONE_BLUE = 14;

func parse_line(line: String):
	var round_regex = RegEx.new()
	round_regex.compile("(?<num>\\d+) (?<color>(red|green|blue))")
	
	var game_id_regex = RegEx.new()
	game_id_regex.compile("Game (?<id>\\d+)")
	
	var id = game_id_regex.search(line).get_string("id");
	var pulls = round_regex.search_all(line)
	
	return {
		"id": int(id),
		"pulls": pulls
	}

func get_maxes(pulls: Array[RegExMatch]):
	var red_max = 0;
	var green_max = 0;
	var blue_max = 0;
	
	for pull in pulls:
		var n = int(pull.get_string("num"))
		var color = pull.get_string("color")
	
		match color:
			"red":
				if n > red_max:
					red_max = n
			"green":
				if n > green_max:
					green_max = n
			"blue":
				if n > blue_max:
					blue_max = n
					
	return {
		"red": red_max,
		"green": green_max,
		"blue": blue_max
	}

func part_one(lines): 
	
	var id_total = 0
	
	for line in lines:
		var game = parse_line(line)
	
		var maxes = get_maxes(game.pulls)
						
		if (maxes.red <= PART_ONE_RED and maxes.green <= PART_ONE_GREEN and maxes.blue <= PART_ONE_BLUE):
			id_total += game.id

	return id_total
	
func part_two(lines):
	var total = 0

	for line in lines:
		var game = parse_line(line)

		var maxes = get_maxes(game.pulls)
		
		var power = maxes.red * maxes.green * maxes.blue
		total += power
		
	return total
