module RoutingHelpers

  def test_denied(arg)
    arg.each do |path, actions|
      describe "on '#{path}' path" do
        actions.each do |action|
          it "'#{action}' action denied" do
            options = {}
            options[action] = path
            expect(options).not_to be_routable
          end
        end
      end
    end
  end
end
