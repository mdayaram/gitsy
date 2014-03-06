module Gitsy
  module Checks
    class Admin

      def self.check?(env)
        return env.config.admins.include? env.config.user
      end

    end
  end
end
