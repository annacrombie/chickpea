require 'chickpea'
require 'benchmark/ips'

puts "initialization"

Benchmark.ips do |bm|
  bm.report(:hash) { { a: { b: { c: { d: 1 } }, bb: false } } }
  bm.report(:chickpea) { Chickpea.new(a: { b: { c: { d: 1 } }, bb: false }) }
  bm.compare!
end

hash = { a: { b: { c: { d: 1 } }, bb: false } }
csth = Chickpea.new(a: { b: { c: { d: 1 } }, bb: false })

puts "accessing"

Benchmark.ips do |bm|
  bm.report(:hash) { hash[:a][:b][:c][:d] }
  bm.report(:chickpea) { csth.a.b.c.d }
  bm.compare!
end
