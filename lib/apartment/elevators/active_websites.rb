require 'apartment/elevators/subdomain'
module Apartment
  module Elevators
    class ActiveWebsite < Subdomain
      def parse_tenant_name(request)
        tenant = super(request)
        by_domain(request) || tenant
      end

      def by_domain(request)
        user = User.find_by(domain: request.domain)
        user && user.subdomain
      end

      def call(env)
        request = Rack::Request.new(env)
        database = @processor.call(request)

        if database
          if User.where(subdomain: database).exist?
            Apartment::Tenant.switch(database) { @app.call(env) }
          else
            #::NotFound.new(Rails.root.join('public/404.html')).call(env)
          end
        else
          @app.call(env)
        end
    end
  end
end
