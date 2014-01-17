require 'yaml'
require 'rack/rewrite'

use Rack::Rewrite do
  r301 '/blog.xml', 'http://blog.travis-ci.com/blog.xml'
  r301 %r{^/blog/?(.*)$}, 'http://blog.travis-ci.com/$1'
  r301 %r{^/docs/?(.*)$}, 'http://docs.travis-ci.com/$1'
  r301 %r{^/(ja|es|fr|pt-BR)/docs/?(.*)$}, 'http://docs.travis-ci.com/$2'
  r301 %r{^/(.+)$}, 'http://docs.travis-ci.com/$1'
  r301 '/', 'http://docs.travis-ci.com'
end

run -> env {
  [200, {}, ""]
}
