#!/usr/bin/ruby -w

# Created by Phaninder Pasupula
# Licensed under Create Commons Attribution License

$lyrics_obj = Hash.new

def mix_it(lyric_file)
	prev_word = nil
	File.open("lyrics/#{lyric_file}", "r") do |infile|
		while (line = infile.gets)
			words = line.split(/\W+/)
			words.each do |word|
				word = word.downcase
				if defined?($lyrics_obj[word]) && $lyrics_obj[word].nil?
					$lyrics_obj[word] = {}
				end
				if defined?($lyrics_obj[prev_word][word]) && !$lyrics_obj[prev_word][word].nil?
					# adding impurity
					$lyrics_obj[prev_word][word] = $lyrics_obj[prev_word][word] + rand($lyrics_obj.length)
				elsif !prev_word.nil?
					$lyrics_obj[prev_word][word] = 1
				end
				prev_word = word
			end
		end
	end
end

def get_max_freq(hash1)
	max = 0
	max_k = ""
	hash1.each do |k, v|
		if v > max
			max = v
			max_k = k
		end
	end
	return max_k
end

["song1_Pearl_Jam.txt",
"song2.txt"].each { |file| mix_it(file)}

p $lyrics_obj

i = 0;
start = "this"
print start
while $lyrics_obj[start]
	start = get_max_freq($lyrics_obj[start])
	print " "+start
	i += 1
	break if i > 10
end