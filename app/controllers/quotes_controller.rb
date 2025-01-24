class QuotesController < ActionController::Base
    include QuotesHelper

    def extract
        text = params[:text] || QUOTED_TEXT

        matches = get_quoted_text(text)
        render json: matches
    end

    def word_map
        text = params[:text] || QUOTED_TEXT
        threshold = params[:threshold] || DEFAULT_THRESHOLD

        quotes = get_quoted_text(text)
        # debugger
        dirty_word_map = build_word_map(quotes)
        clean_word_map = clean_word_map(dirty_word_map, threshold)
        # debugger
        render json: clean_word_map
    end
end
