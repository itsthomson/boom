# coding: utf-8

# Platform is a centralized point to shell out platform specific functionality
# like clipboard access or commands to open URLs.
#
#
# Clipboard is a centralized point to shell out to each individual platform's
# clipboard, pasteboard, or whatever they decide to call it.
#
module Boom
  class Platform
    class << self

      # Public: tests if currently running on darwin.
      #
      # Returns true if running on darwin (MacOS X), else false
      def darwin?
        !!(RUBY_PLATFORM =~ /darwin/)
      end

      # Public: opens a given Item's value in the browser. This
      # method is designed to handle multiple platforms.
      #
      # Returns a String explaining what was done
      def open(item)
        open_command = darwin? ? 'open' : 'xdg-open'

        `#{open_command} '#{item.url.gsub("\'","\\'")}'`

        "Boom! We just opened #{item.value} in your browser."
      end

      # Public: copies a given Item's value to the clipboard. This method is
      # designed to handle multiple platforms.
      #
      # Returns a String explaining what was done
      def copy(item)
        copy_command = darwin? ? "pbcopy" : "xclip -selection clipboard"

        `echo '#{item.value.gsub("\'","\\'")}' | tr -d "\n" | #{copy_command}`

        "Boom! We just copied #{item.value} to your clipboard."
      end
    end
  end
end