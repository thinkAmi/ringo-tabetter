# -*- coding: utf-8 -*-

# Helper methods defined here can be accessed in any controller or view in the application

RingoTabeta.helpers do
  # def simple_helper_method
  #  ...
  # end
  def add_color(apples)

    colors = YAML.load_file("apples.yaml")

    apples.each do |apple|
      apple.dummy_for_color = colors.fetch(apple.name)
      apple.amount = apple.amount.to_i
    end

    apples
  end
end
