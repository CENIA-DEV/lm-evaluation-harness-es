# Define variables for common parameters
DEVICE=cuda:0
BATCH_SIZE=8

# Define variables for different models
PHI_2=microsoft/phi-2
PHI_3=microsoft/Phi-3-mini-128k-instruct

# Cache dir (optional)
CACHE_DIR ?=

# Define variable for the specific task and section
TASK_M_MMLU_ES=m_mmlu_es
TASK_TRUTHFULQA_ES_MC1=truthfulqa_es_mc1
TASK_TRUTHFULQA_ES_MC2=truthfulqa_es_mc2

# Conditional to include cache_dir if set
ifdef CACHE_DIR
CACHE_ARG=cache_dir=$(CACHE_DIR)
else
CACHE_ARG=
endif

# Phony targets to avoid conflicts with files of the same name
.PHONY: all test-phi-2-m-mmlu-es test-phi-3-m-mmlu-es

# Default target
all: test-phi-2-m-mmlu-es test-phi-3-m-mmlu-es

# Target for testing phi-2 on MLQA Spanish section
test-phi-2-m-mmlu-es:
	lm_eval --model hf --model_args pretrained=$(PHI_2),$(CACHE_ARG) --tasks $(TASK_M_MMLU_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE)

# Target for testing phi-3 on MLQA Spanish section
test-phi-3-m-mmlu-es:
	lm_eval --model hf --model_args pretrained=$(PHI_3),$(CACHE_ARG) --tasks $(TASK_M_MMLU_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE)
