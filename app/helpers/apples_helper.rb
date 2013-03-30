# -*- coding: utf-8 -*-

# Helper methods defined here can be accessed in any controller or view in the application

RingoTabeta::App.helpers do
  # def simple_helper_method
  #  ...
  # end
  def add_color(apples)
    # colors = load_colors

    # apples.each do |apple|
    #   apple.dummy_for_color = colors.fetch(apple.name)
    #   apple.amount = apple.amount.to_i
    # end

    # apples

    colors = load_colors

    results = []
    result = Struct.new(:name, :amount, :color)
    apples.each do |apple|
      results << result.new(apple.name, apple.amount.to_i, colors.fetch(apple.name))
    end

    results

  end


  def collect_by_name(apples)
    colors = load_colors

    results = []
    result = Struct.new(:name, :amount, :color)
    name = apples[0].name
    amounts = Array.new(12, 0)

    apples.each do |apple|
      if name != apple.name
        results << result.new(name, amounts, colors.fetch(name))

        name = apple.name
        amounts = Array.new(12,0)
      end

      amounts[apple.month.to_i - 1] = apple.amount.to_i
    end

    results << result.new(name, amounts, colors.fetch(name))
  end


  def load_colors
    YAML.load_file("apples.yaml")
  end
end
