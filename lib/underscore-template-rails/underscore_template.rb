require 'sprockets'
require 'tilt'
require 'action_view'
require 'action_view/helpers'

module UnderscoreTemplateRails
  class UnderscoreTemplate < Tilt::Template
    include ActionView::Helpers::JavaScriptHelper

    def self.default_mime_type
      'application/javascript'
    end

    def prepare
    end

    def variable
      Rails.configuration.underscore_templates.variable
    end

    def evaluate(scope, locals, &block)
      %{window.#{variable} = #{variable} || []; #{variable}["#{template_name(scope)}"] = _.template("#{escape_javascript(data)}");}
    end

    private

    def template_name(scope)
      scope.logical_path.sub(/^(backbone\/)?templates\//,'')
    end
  end
end
