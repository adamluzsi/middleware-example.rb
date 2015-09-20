
    require 'middleware'

    # Basic middleware that just prints the inbound and
    # outbound steps.
    class Trace

      def initialize(app, value)
        @app   = app
        @value = value
      end

      def call(env)
        puts "--> #{@value}"
        @app.call(env)
        puts "<-- #{@value}"
      end

    end

    # Build the actual middleware stack which runs a sequence
    # of slightly different versions of our middleware.
    stack = Middleware::Builder.new do
      use Trace, "A"
      use Trace, "B"
      use Trace, "C"
    end

    # Run it!
    stack.call(nil)
    # --> A
    # --> B
    # --> C
    # <-- C
    # <-- B
    # <-- A

