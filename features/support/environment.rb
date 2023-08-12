class Environment
  def get_parameters(env_name)
    # env_name = "dev"
    env_name = ENV['PLATFORM'] || 'dev'
    flunk("Test environment not specified. Set PLATFORM env. variable before running tests.") if env_name.nil? or env_name.empty?
    env_name = env_name.upcase
    parameters = {}
    valid_envs = %w(DEV STG PRD)
    unless valid_envs.include? env_name
      flunk("TEST SCRIPT ERROR: Wrong environment name: #{env_name}. Supported environments: #{valid_envs}")
    end

    case env_name
    when 'DEV'
      parameters[:api_host] = "python-greetings-local:3000"
    when 'STG'
      parameters[:api_host] = "python-greetings-stg:3000"
    when 'PRD'
      parameters[:api_host] = "python-greetings-prd:3000"
    else
      #   nothing
    end
    parameters
  end
end
