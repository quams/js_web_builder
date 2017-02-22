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
	end

end