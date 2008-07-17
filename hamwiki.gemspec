Gem::Specification.new do |s|
  s.name = "HAMwiki"
  s.version = "0.0.2"
  s.date = "2008-06-16"
  s.summary = "A super fast wiki comprised of a JS driven client and a purpose build rack server."
  s.email = "colin@logaan.net"
  s.homepage = "http://github.com/logaan/hamwiki"
  s.author = "Colin Campbell-McPherson"
  
  s.description = <<-END
    200 lines of code, to manage all your documents in a microsecond, or your money back.
  END
  
  s.files = ["hamwiki.gemspec", "Rakefile", "README.rdoc", "client.html", "server.rb", "documents/index", "documents/toc"]
end
