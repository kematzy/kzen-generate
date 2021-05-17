

module Kzen

  module FormatHelpers

    def self.included(base) #:nodoc:
      super(base)
      base.extend ClassMethods
    end

    module ClassMethods
    end


    private

      #### FORMAT HELPERS

      def bold_bright_green(str)
        format.bold.bright_green("'#{str}'")
      end
      alias_method :bbg, :bold_bright_green

      def dim_bright_green(str)
        format.dim.bright_green("'#{str}'")
      end
      alias_method :dbg, :dim_bright_green

      def bright_green(str)
        format.bright_green("'#{str}'")
      end
      alias_method :bg, :bright_green

      def bold_bright_red(str)
        format.bold.bright_red("'#{str}'")
      end
      alias_method :bbr, :bold_bright_red

      def bold_bright_cyan(str)
        format.bold.bright_cyan("'#{str}'")
      end
      alias_method :bbc, :bold_bright_cyan

      def dim_cyan(str)
        format.dim.cyan("'#{str}'")
      end
      alias_method :dc, :dim_cyan

      def bold_bright_yellow(str)
        format.bold.bright_yellow("'#{str}'")
      end
      alias_method :bby, :bold_bright_yellow

      def bold_dim_yellow(str)
        format.dim.yellow("'#{str}'")
      end
      alias_method :bdy, :bold_dim_yellow

      def bold(str)
        format.bold(str)
      end

      def dim(str)
        format.dim.italic(str)
      end

      def fmtmenu(key, desc)
        "#{format.bold.cyan(key)} #{dim('-')} #{format.dim(desc)}"
      end

  end

end
