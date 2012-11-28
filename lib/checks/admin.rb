
module Gitsy
  module Checks
    class Admin

      def self.check?(config, project, write)
        return config.admins.include? (config.user)
      end

    end
  end
end
