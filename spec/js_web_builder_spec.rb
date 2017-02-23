require 'spec_helper'

describe JSWebBuilder do

	it "has a version number" do
		JSWebBuilder::VERSION.wont_be_nil
	end

    describe JSWebBuilder::BuildTask do

        it "concatenates the js files" do
            JSWebBuilder::BuildTask.new(:build) do |b|
                b.outdir    << File.join(File.dirname(__FILE__),"public/")
                b.inputdirs << File.join(File.dirname(__FILE__),"assets/")
            end
            Rake::Task[:build].invoke
        end

    end


	describe JSWebBuilder::FileReader do
		let(:reader) { JSWebBuilder::FileReader.new(:file => File.expand_path('../assets/main.js', __FILE__)) }

		it "must return the correct ordered array of filenames" do
			reader.include_list.must_equal ["lib/module1.js", "./lib/module2.js", "lib/fu.js"]
		end

        it "must return the concatenated files in the correct order as a string" do
            tester = reader.execute
            found = false

            # module1.js
            tester.each_line do |line|
                if line =~ /^\/\/ First test module/ 
                    found = true
                    break
                end
            end
            found.must_equal true, "lib/module1.js not included"

            # module2.js
            found = false
            tester.each_line do |line|
                if line =~ /^\/\/ Second test module/ 
                    found = true
                    break
                end
            end
            found.must_equal true, "lib/module2.js not included"

            # fu.js
            found = false
            tester.each_line do |line|
                if line =~ /^\/\/ Here might be dragons!/ 
                    found = true
                    break
                end
            end
            found.must_equal true, "lib/fu.js not included"
        end

	end

end