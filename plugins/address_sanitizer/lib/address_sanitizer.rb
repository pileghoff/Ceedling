# =========================================================================
#   Ceedling - Test-Centered Build System for C
#   ThrowTheSwitch.org
#   Copyright (c) 2010-24 Mike Karlesky, Mark VanderVoord, & Greg Williams
#   SPDX-License-Identifier: MIT
# =========================================================================


require 'ceedling/plugin'

class AddressSanitizer < Plugin
  def post_test_fixture_execute(arg_hash)
    return unless arg_hash[:shell_result][:exit_code] != 0

    # Collect the address sanitizer report
    asan_report_started = false
    crash_report = ""
    arg_hash[:shell_result][:stderr].each_line do |line|
        if !asan_report_started and line =~ /==\d+==\w+: AddressSanitizer/
            asan_report_started = true
        end

        if asan_report_started
            crash_report += line
        end

        if asan_report_started and line =~ /==\d+==ABORTING/
            asan_report_started = false
        end
    end

    return if crash_report.empty?
    @ceedling[:loginator].log("Address sanitizer report:\n #{crash_report}", Verbosity::NORMAL)


  end
end