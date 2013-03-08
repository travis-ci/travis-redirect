require 'yaml'
redirects = YAML.load_file('redirects.yml')

run -> env {
  host     = Rack::Request.new(env).host
  location = redirects[host] || 'https://travis-ci.org'
  [302, {'Location' => location, 'Content-Type' => 'text/plain'}, ["redirecting to #{location}"]]
}