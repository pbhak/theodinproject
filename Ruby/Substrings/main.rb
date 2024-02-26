def substrings(word, dictionary)
  word = word.downcase.split(' ')
  dictionary.reduce(Hash.new(0)) do |result, value|
    word.each do |word_value|
      if word_value.include?(value)
        result[value] += 1
      end
    end
    result
  end
end

dictionary = ['below', 'down', 'go', 'going', 'horn', 'how', 'howdy', 'it', 'i', 'low', 'own', 'part', 'partner', 'sit']
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
