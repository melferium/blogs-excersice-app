domain_list = User.pluck(:domain)
domain_valid = domain_list.compact.push('lvh.me')

#Rails.application.config.session_store :cookie_store, :key => '_domain_session', :domain => [ 'lvh.me', 'melfer.ium']
Rails.application.config.session_store :cookie_store, :key => '_domain_session', :domain => domain_valid