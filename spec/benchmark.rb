require 'cstash'
require 'benchmark/ips'

puts "initialization"

Benchmark.ips do |bm|
  bm.report(:hash) { { a: { b: { c: { d: 1 } }, bb: false } } }
  bm.report(:cstash) { CStash::Stash.new(a: { b: { c: { d: 1 } }, bb: false }) }
  bm.compare!
end

hash = { a: { b: { c: { d: 1 } }, bb: false } }
csth = CStash::Stash.new(a: { b: { c: { d: 1 } }, bb: false })

puts "accessing"

Benchmark.ips do |bm|
  bm.report(:hash) { hash[:a][:b][:c][:d] }
  bm.report(:cstash) { csth.a.b.c.d }
  bm.compare!
end
