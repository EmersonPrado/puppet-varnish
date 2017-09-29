module Puppet::Parser::Functions
  newfunction(:if_block, :type => :rvalue) do |args|
    block_string = ''
    args.each do |rules_hash|
      block_string += "\n"
      block_string += "  if (req.#{rules_hash['key']} ~ \""
      block_string += rules_hash['values'].join("\" ||\n    req.#{rules_hash['key']} ~ \"")
      block_string += "\") {\n"
      block_string += "      #{rules_hash['action']};\n"
      block_string += "  }\n"
    end
    block_string
  end
end
