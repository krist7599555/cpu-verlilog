#!/usr/bin/env ruby
rtype = { add: 32, sub: 34, and: 36, or: 37, xor: 38, nor: 39, slt: 42 }
ltype = { ori: 13 }
speci = { "$zero": nil }

inp = File.open('input.txt')
inp.each do |line|
  cmd, b, c, d = line.split
  if rtype.key? cmd.to_sym
    print '000000_%05b_%05b_%05b_00000_%06b' % [b, c, d, rtype[cmd.to_sym]]
    puts ' // %s $%s $%s $%s' % line.split
  elsif ltype.key? cmd.to_sym
    print '%06b_%05b_%05b_%016b ' % [ltype[cmd.to_sym], b, c, d]
    puts ' // %s $%s $%s #%s' % line.split
  end
end
