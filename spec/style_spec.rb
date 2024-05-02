# =========================================================================
#   Ceedling - Test-Centered Build System for C
#   ThrowTheSwitch.org
#   Copyright (c) 2010-24 Mike Karlesky, Mark VanderVoord, & Greg Williams
#   SPDX-License-Identifier: MIT
# =========================================================================

require 'spec_system_helper'

describe "Ceedling" do
  include CeedlingTestCases

  before :all do
    @c = SystemContext.new
    @c.deploy_gem
  end

  after :all do
    @c.done!
  end

  before { }
  after { }

  describe "ruby code style`" do
    before do
      @c.with_context do
        #@output = `bundle exec ruby -S ceedling examples 2>&1`
      end
    end

    xit "should verify style of all Ruby files" do
      #expect(@output).to match(/temp_sensor/)
      command = "rubocop " \
                "./bin ./config ./examples ./lib ./plugins ./spec " \
                #"--auto-correct " \       # Enable this line to attempt to autocorrect
                #"--auto-gen-config " \    # Enable this line to attempt to update todo list
                "--config vendor/unity/test/.rubocop.yml"
      puts `#{command}`
    end
  end


  describe "C code style`" do
    before do
      @c.with_context do
        #@output = `bundle exec ruby -S ceedling examples 2>&1`
      end
    end

    xit "should verify style of C and header files" do
      #expect(@output).to match(/temp_sensor/)
      command = "AStyle " \
              "--style=allman --indent=spaces=4 --indent-switches --indent-preproc-define --indent-preproc-block " \
              "--pad-oper --pad-comma --unpad-paren --pad-header " \
              "--align-pointer=type --align-reference=name " \
              "--add-brackets --mode=c --suffix=none " \
              "./assets/*.* examples/**/*.*"
      puts `#{command}`
    end
  end
end
