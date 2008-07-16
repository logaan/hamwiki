#!/usr/bin/env ruby

require 'rubygems'
require 'rack'
require 'pp'

class HamWiki
  def call env
    case env["PATH_INFO"]
      when "/"
        [200, {"Content-Type" => "text/html"},
          [File.read(File.join(File.dirname(__FILE__), "client.html"))]]
      else
        document = File.join(File.dirname(__FILE__), "documents", env["PATH_INFO"])
        
        if File.file?(document) && File.readable?(document)
          [200, {
             "Last-Modified"  => File.mtime(document).rfc822,
             "Content-Type"   => "text/plain",
             "Content-Length" => File.size(document).to_s
           }, File.read(document)]
        else
          [404, {"Content-Type" => "text/plain"},
            ["404: File not found.\n"]]
        end
    end
  end
end

Rack::Handler::WEBrick.run(Rack::Lint.new(HamWiki.new), :Port => 9292)
