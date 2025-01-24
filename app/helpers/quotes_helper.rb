module QuotesHelper
  IN_QUOTES_REGEX =/"(.*?)"/.freeze
  QUOTED_TEXT = '
      "In some ways, but on the other hand…" I trailed off, thinking about how the year had brought much more than I bargained for.
      "What about your other hand?" she asked, leaning over to inspect it, awkwardly almost tripping us. We both laughed as I explained the phrase. She’d started picking up some of them.
      "You’re a riot," she teased, deploying another Earth phrase I’d taught her.
      "I was thinking about how so much is different, and yet, not much changes this summer."
      "How do you mean?"
  '.freeze
  BASIC_WORDS = [ "the", "was", "a", "i",
      "you", "your", "them", "they", "he", "she", "him", "her", "it"
      ].freeze
  DEFAULT_THRESHOLD = 0

  def build_word_map(quotes)
    word_map = {}
    quotes.each { |quote|
        words = quote.delete("?!.,").gsub("…", "").split(" ")
        words.each { |word|
            word = word.downcase
            next if BASIC_WORDS.include?(word)
            if word_map[word] == nil
                word_map[word] = 1
                next
            end
            word_map[word] = (word_map[word] + 1)
        }
    }
    word_map
  end

  def clean_word_map(word_map, threshold = 0)
      marked_for_delete = []
      word_map.each { |key, val|
          marked_for_delete << key if val < threshold
      }
      marked_for_delete.each { |key|
          word_map.delete(key)
      }
      word_map
  end

  def get_quoted_text(text = QUOTED_TEXT)
      text.scan(IN_QUOTES_REGEX).flat_map(&:itself)
  end
end
