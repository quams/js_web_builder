require "js_web_builder/version"
require 'rake'
require 'rake/tasklib'

module JSWebBuilder 

class BuildTask < Rake::TaskLib

	# Name of build task. (default is :js_build)
    attr_accessor :name

    # Description of the build task. (default is 'Building/Concatenating the JS files')
    attr_accessor :description

    # Glob pattern to match input files. (default is '*.js')
    attr_accessor :pattern

    # Task prerequisites.
    attr_accessor :deps

    # The output directory (default is '.')
    attr_accessor :outdir

    # The input directories, can be a single string or an array
    attr_accessor :inputdirs

    # Create a testing task.
    def initialize(name=:js_build)
        @name = name
        @description = "Building/Concatenating the JS files"
        @pattern = '*.js'
        @deps = []
        @outdir = "."
        @inputdirs = []

        # don't look here!
        @file_list = []

        yield self if block_given?
        define
    end # initialize

    # Create the tasks defined by this task lib.
    def define 
        desc @description
        task @name => Array(deps) do
            unless Dir.exist?(@outdir)
                Dir.mkdir(@outdir)
            end
            make_file_list
            @file_list.each do |target|
                js = target.execute
                target_file = File.join(@outdir,File.basename(target.file))
                File.open(target_file, 'w') { |f| f.write(js) }
            end
        end

        self
    end # define

    def make_file_list # :nodoc:
        @inputdirs.each do |dir|
            Rake::FileList[File.join(dir,@pattern)].each do |file|
                @file_list << TargetFile.new(:file => file)
            end
        end
    end

end # class BuildTask



class TargetFile

    # The full path of the base file
	attr_reader :file 			

    # The include list after reading the base file
	attr_reader :include_list

    # create file reader
	def initialize params = {}
		params.each { |key, value| send "#{key}=", value }
	end

    # set the filename and creates the include list
	def file=(name)
		@file = name
		create_include_list
	end

    # executes the concatenation and returns the result for further fun
    def execute
        res = @include_list.map { |re_file| IO.read File.join(File.dirname(@file),re_file) }
        res << IO.read(@file)
        res.join "\n"
    end

	def create_include_list # :nodoc:
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

end # class TargetFile

end # module JSWebBuilder
