require 'yaml'
require 'rack/rewrite'

use Rack::Rewrite do
  r301 %r{^/blog/?(.*)$}, 'http://blog.travis-ci.com/$1'
  r301 %r{^/docs/?(.*)$}, 'http://docs.travis-ci.com/$1'
  r301 '/', 'http://docs.travis-ci.com'
end

run -> env {
  [200, {}, ""]
}
