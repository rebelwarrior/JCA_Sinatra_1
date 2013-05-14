#figure out how to test webp capabilty.
get '/' do
  request.accept? 'webp'
end