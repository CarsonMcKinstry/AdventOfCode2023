extends Node2D

const WORD_TO_DIGIT = {
	"one": 1,
	"two": 2,
	"three": 3,
	"four" : 4,
	"five" : 5,
	"six" : 6,
	"seven": 7,
	"eight": 8,
	"nine": 9
}

@onready var input = $FileLoader.as_string_array()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var p_one = part_one()

	print("Part One: ", p_one)

	var p_two = part_two()
	
	print("Part Two: ", p_two)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func part_one() -> int:
	
	var regex = RegEx.new()
	regex.compile("\\d");
	
	var total = 0
	
	for line in input:
		var results = regex.search_all(line)
		
		if results.size() > 0:
			var first = results[0].get_string(0)
			var last = results[-1].get_string(0)
			
			var num = first + last
			
			total += int(num)
	
	return total

var digits = "123456789"
var letters = "abcdefghijklmnopqrstuvwxyz"

func part_two() -> int:

	var digit_as_word_regex = RegEx.new()
	digit_as_word_regex.compile("one|two|three|four|five|six|seven|eight|nine")
	
	var total = 0
	
	for line in input:
		if line.length() > 0:
			var first = -1;
			var last = -1;
			
			var word = ""
			
			for char in line:
				if char in digits:
					first = int(char)
					word = ""
					break
				elif char in letters:	
					word += char
					
					var result = digit_as_word_regex.search(word)
					if result:
						first = WORD_TO_DIGIT[result.get_string()]
						word = ""
						break

			for char in reverse(line):
				if char in digits:
					last = int(char)
					word = ""
					break
				elif char in letters:
					word = char + word
					
					var result = digit_as_word_regex.search(word)
					if result:
						last = WORD_TO_DIGIT[result.get_string()]
						word = ""
						break
			total += first * 10 + last
		
	return total

func reverse(arg: String) -> String:
	var arr := arg.to_utf32_buffer().to_int32_array()
	arr.reverse()
	return arr.to_byte_array().get_string_from_utf32()
