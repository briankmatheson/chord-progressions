#!/usr/bin/env ruby


def build_progression (number_of_bars, starting_chord)
	chords = [ "a", "b", "c", "d", "e", "f", "g"]
	starting_chord_index = chords.find_index(starting_chord)
	progression = []
	chord_indexes_used = []
	include_second_and_sixth_chords = false
	number_of_bars = number_of_bars - 1
	chord_indexes = build_chord_indexes(starting_chord_index)

	progression.push chords[chord_indexes[0]]
	chord_indexes_used.push 0

	number_of_bars.times do 

		last_chord_index = chord_indexes_used.size - 1
		next_chord_index = get_next_chord_index(include_second_and_sixth_chords,
												chord_indexes)
		if last_chord_index > 1
			while chords_are_repeated_too_much(next_chord_index, 
											   last_chord_index,
											   chord_indexes_used)
				next_chord_index = get_next_chord_index(include_second_and_sixth_chords,
														chord_indexes)
			end
		end

		chord_indexes_used.push next_chord_index
		if chord_indexes_used.include?(chord_indexes[1]) && 
		   chord_indexes_used.include?(chord_indexes[2])
			include_second_and_sixth_chords = true
		end

		progression.push chords[next_chord_index]
	end

	return progression
end

def chords_are_repeated_too_much(next_chord_index, last_chord_index, chord_indexes_used)
	if next_chord_index == chord_indexes_used[last_chord_index]
		if chord_indexes_used.size < 1
			return false 
		else
			if next_chord_index == chord_indexes_used[last_chord_index - 1]
				return true
			end
		end
	end
	return false
end

def get_next_chord_index(include_second_and_sixth_chords, chord_indexes)
	if include_second_and_sixth_chords
		max_chords_to_use = 5
	else
		max_chords_to_use = 3
	end

	random_number = rand * max_chords_to_use
	next_chord_number = random_number.to_i
	next_chord_index = chord_indexes[next_chord_number]

	return next_chord_index
end

def get_first_chord_index
	random_number = rand * 7
	return random_number.to_i
end

def build_chord_indexes(starting_chord_index)

	if starting_chord_index
		first_chord_index = starting_chord_index
	else
		first_chord_index = get_first_chord_index
	end

	second_chord_index = (first_chord_index + 1) % 7
	fourth_chord_index = (first_chord_index + 3) % 7
	fifth_chord_index = (first_chord_index + 4) % 7
	sixth_chord_index = (first_chord_index +5) % 7

	chord_indexes = [ first_chord_index,
					  fourth_chord_index,
					  fifth_chord_index,
					  sixth_chord_index,
					  second_chord_index
					]

	return chord_indexes
end


puts build_progression(ARGV[0].to_i, ARGV[1])
