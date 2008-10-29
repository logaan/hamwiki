#!/usr/bin/env ruby

require 'rubygems'
require 'rack'

# The HamWiki class presents an interface to rack and handles all requests
class HamWiki
  # Documents are stored in the documents directory within the HAMwiki project
  DOCUMENTS_PATH = File.join(File.dirname(__FILE__), "documents")

  # Rack will call call every time a request is made. Our call method will
  # simply pick between serving up the root wiki page or an individual document
  def call env
    if env["PATH_INFO"] == "/"
      root_response
    else
      retrieve_document env["PATH_INFO"]
    end
  end

 protected

  # If they're requesting a document we'll serve it if it's available, or give
  # a not found response
  def retrieve_document path_info
    document = File.join(DOCUMENTS_PATH, path_info)
    if File.file?(document) && File.readable?(document)
      serve_document document
    else
      not_found
    end
  end

  # When someone accesses the root they're served up the client.html file. This
  # contains the javascript code that'll grab and format the plain text
  # documents and allow for navigation between then.
  def root_response
    [200, {"Content-Type" => "text/html"},
      [File.read(File.join(File.dirname(__FILE__), "client.html"))]]
  end

  # A successful http response with the document contents and meta-data
  def serve_document document
      [200, {
         "Last-Modified"  => File.mtime(document).rfc822,
         "Content-Type"   => "text/plain",
         "Content-Length" => File.size(document).to_s
       }, File.read(document)]
  end

  # A 404 not found http response
  def not_found_response
    [404, {"Content-Type" => "text/plain"},
      ["404: File not found.\n"]]
  end
end

# Bootstrap the HamWiki class
Rack::Handler::WEBrick.run(Rack::Lint.new(HamWiki.new), :Port => 9292)
