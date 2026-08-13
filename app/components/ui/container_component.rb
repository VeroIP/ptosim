module Ui
  class ContainerComponent < ApplicationComponent
    def initialize(tag: :div, class: nil)
      @tag = tag
      @extra_class = binding.local_variable_get(:class)
    end

    def call
      content_tag(@tag, content, class: [ "ps-container", @extra_class ].compact.join(" "))
    end
  end
end
