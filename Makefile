# Define variables for common parameters
DEVICE=cuda:0
BATCH_SIZE=8

# Define variables for different models
PHI_2=microsoft/phi-2
PHI_3=microsoft/Phi-3-mini-128k-instruct

# Cache dir (optional)
CACHE_DIR ?=

# Define variable for the specific task and section
TASK_MMLU_ES=m_mmlu_es
TASK_HELLASWAG_ES=latam_hellaswag

# Conditional to include cache_dir if set
ifdef CACHE_DIR
CACHE_ARG=cache_dir=$(CACHE_DIR)
else
CACHE_ARG=
endif

# Phony targets to avoid conflicts with files of the same name
.PHONY: all test-phi-2-mmlu-es test-phi-3-mmlu-es

# Default target
all: test-phi-2-mmlu-es test-phi-3-mmlu-es

# phi-2 on MMLU-ES
test-phi-2-mmlu-es:
	lm_eval --model hf --model_args pretrained=$(PHI_2),$(CACHE_ARG) --tasks $(TASK_MMLU_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE)

# phi-2 on HELLASWAG_ES
test-phi-2-hellaswag-es:
	lm_eval --model hf --model_args pretrained=$(PHI_2),$(CACHE_ARG) --tasks $(TASK_HELLASWAG_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE)

# phi-3 on MMLU-ES
test-phi-3-mmlu-es:
	lm_eval --model hf --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG) --tasks $(TASK_MMLU_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template

# phi-3 on HELLASWAG_ES
test-phi-3-hellaswag-es:
	lm_eval --model hf --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG) --tasks $(TASK_HELLASWAG_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template
