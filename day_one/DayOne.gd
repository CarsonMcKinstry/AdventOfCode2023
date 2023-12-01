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

func part_one(input: Array[String]) -> int:
	
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



func part_two(input: Array[String]) -> int:
	
	var total = 0
	
	for line in input:
		if line.length() > 0:
			var values = Vector2(-1,-1)
			
			values = calculate_line(line, values, false)
			values = calculate_line(reverse(line), values, true)

			total += values.x * 10 + values.y
		
	return total

func calculate_line(line: String, values: Vector2, reversed: bool):
	
	var digits = "123456789"
	var letters = "abcdefghijklmnopqrstuvwxyz"
	
	var digit_as_word_regex = RegEx.new()
	digit_as_word_regex.compile("one|two|three|four|five|six|seven|eight|nine")
	
	var word = ""
	
	for char in line:
		if char in digits:
			values = update_values(values, int(char))
			word = ""
			break
		elif char in letters:
			if reversed:
				word = char + word
			else:
				word += char
			
			var search_result = digit_as_word_regex.search(word)
			
			if search_result:
				values = update_values(values, word_to_digit(search_result.get_string(0)))
				word = ""
				break
				
	return values

func reverse(arg: String) -> String:
	var arr := arg.to_utf32_buffer().to_int32_array()
	arr.reverse()
	return arr.to_byte_array().get_string_from_utf32()

func word_to_digit(word: String) -> int:
	return WORD_TO_DIGIT[word]
	
func update_values(values: Vector2, value: int) -> Vector2:
	if values.x == -1:
		values.x = value
	else:
		values.y = value
	
	return values
