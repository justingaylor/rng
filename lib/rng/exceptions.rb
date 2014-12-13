module Rng
  class FileLoadError < Exception
  end
  class SegmentError < Exception
    def initialize(original_name, current_name)
      super("Cannot segment name '#{original_name.capitalize}'. " +
            "It is likely that a required syllable is missing at " +
            "'#{current_name}'.")
    end
  end
end