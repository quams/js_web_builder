require "js_web_builder/version"

module JSWebBuilder 

class FileReader
	attr_reader :file 			# accessor is done manually
	attr_reader :include_list

	def initialize params = {}
		params.each { |key, value| send "#{key}=", value }
	end

	def file=(name)
		@file = name
		create_include_list
	end

	private

	def create_include_list 
		unless File.readable?(@file)
			raise "Can't open File: #{@file}"
		end

		@include_list = []
		_i = 0
		File.readlines(@file).each do |line|
			if _scan = line.match(/^\s*\/\/=\s+require\s+(.+)$/)
				@include_list << _scan[1]

				_full = File.join(File.dirname(@file),_scan[1])
				unless File.readable?(_full)
					raise "Can't read #{_full} required from #{@file} in line #{_i}"
				end

				_i+=1
			end
		end
	end

end

end
