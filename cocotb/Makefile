# =============================================================================
# cocotb/Makefile — the cocotb testbenches.
#
#   make            run the mock testbench
#   make WAVE=1     run it with a VCD trace
#   make clean      remove the build tree and the results file
#
# The sources are given as paths relative to this directory. That is not
# cosmetic: the project lives under a path with spaces ("OneDrive - Yildiz
# Technical University"), and Verilator is invoked with the source list on
# the command line, where a space would split the path in two. Relative paths
# from this directory contain no spaces.
#
# The build tree is kept outside the project for the same reason: GNU Make
# misbehaves when the build directory's path contains spaces.
#
# This file is run through a copy with LF line endings, see cocotb/common.sh.
# =============================================================================

SIM           ?= verilator
TOPLEVEL_LANG ?= verilog

COCOTB_TOPLEVEL     ?= mock_lsu
COCOTB_TEST_MODULES ?= test_mock_lsu

VERILOG_SOURCES ?= rtl/mock_lsu.sv

# The project's RTL and the fpnew package produce warnings that Verilator
# treats as fatal by default. The SystemVerilog flow uses -Wno-fatal too.
COMPILE_ARGS += -Wno-fatal

# The build tree lives outside the project, like the one tb/common.sh uses.
DOLUNAY_BUILD_DIR ?= $(HOME)/dolunay-sim

# Verilator regenerates its makefile only when the sources change, so a
# change of Verilator version would silently reuse the previous version's
# build tree. Put the version in the path of the build tree instead.
VERILATOR_VERSION := $(shell verilator --version | cut -d " " -f 2)
SIM_BUILD         ?= $(DOLUNAY_BUILD_DIR)/cocotb_mock_$(VERILATOR_VERSION)

ifeq ($(WAVE),1)
SIM_BUILD := $(DOLUNAY_BUILD_DIR)/cocotb_mock_$(VERILATOR_VERSION)_wave
COMPILE_ARGS += --trace --trace-structs
SIM_ARGS += --trace
endif

# The test module lives in tests/, which is not on the import path by default.
export PYTHONPATH := $(CURDIR)/tests:$(PYTHONPATH)

ifeq (, $(shell command -v cocotb-config))
$(error cocotb is not on the PATH. Use cocotb/run_mock.sh, or activate the virtualenv: source ~/venvs/dolunay-cocotb/bin/activate)
endif

include $(shell cocotb-config --makefiles)/Makefile.sim
