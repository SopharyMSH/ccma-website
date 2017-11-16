set :production

set :app_name, 'cambodia_chinese_association'

server '13.228.102.121', user: 'deployer', roles: %w{app web db}
