$:.unshift "lib"

require "bundler/setup"
require "amp/block"

run Amp::Block
