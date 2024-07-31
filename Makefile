DEVICE=cuda:0
BATCH_SIZE=8

# List of models
PHI_2=microsoft/phi-2
PHI_3=microsoft/Phi-3-mini-128k-instruct

# List of tasks
TASK_MMLU_ES=m_mmlu_es
TASK_HELLASWAG_ES=latam_hellaswag
TASK_PSU=psu
TASK_PSU_LENGUAJE=psu_lenguaje
TASK_PSU_HISTORIA=psu_historia

# cache dir (optional)
# conditional to include cache_dir if set
CACHE_DIR ?=
ifdef CACHE_DIR
CACHE_ARG=cache_dir=$(CACHE_DIR)
else
CACHE_ARG=
endif

# required to avoid conflicts with files of the same name
.PHONY: all test-phi-2-mmlu-es test-phi-3-mmlu-es test-phi-2-hellaswag-es test-phi-3-hellaswag-es test-phi-2-psu test-phi-3-psu test-phi-2-psu-lenguaje test-phi-3-psu-lenguaje test-phi-2-psu-historia test-phi-3-psu-historia

# default targets
all: test-phi-2-mmlu-es test-phi-3-mmlu-es test-phi-2-hellaswag-es test-phi-3-hellaswag-es test-phi-2-psu test-phi-3-psu test-phi-2-psu-lenguaje test-phi-3-psu-lenguaje test-phi-2-psu-historia test-phi-3-psu-historia

###############
# Phi 2 TESTS #
###############

# phi-2 on MMLU-ES
test-phi-2-mmlu-es:
	lm_eval --model hf --model_args pretrained=$(PHI_2),$(CACHE_ARG) --tasks $(TASK_MMLU_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE)

# phi-2 on HELLASWAG_ES
test-phi-2-hellaswag-es:
	lm_eval --model hf --model_args pretrained=$(PHI_2),$(CACHE_ARG) --tasks $(TASK_HELLASWAG_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE)

# phi-2 on PSU
test-phi-2-psu:
	lm_eval --model hf --model_args pretrained=$(PHI_2),$(CACHE_ARG) --tasks $(TASK_PSU) --device $(DEVICE) --batch_size $(BATCH_SIZE)

# phi-2 on PSU Lenguaje
test-phi-2-psu-lenguaje:
	lm_eval --model hf --model_args pretrained=$(PHI_2),$(CACHE_ARG) --tasks $(TASK_PSU_LENGUAJE) --device $(DEVICE) --batch_size $(BATCH_SIZE)

# phi-2 on PSU Historia
test-phi-2-psu-historia:
	lm_eval --model hf --model_args pretrained=$(PHI_2),$(CACHE_ARG) --tasks $(TASK_PSU_HISTORIA) --device $(DEVICE) --batch_size $(BATCH_SIZE)

###############
# Phi 3 TESTS #
###############

# phi-3 on MMLU-ES
test-phi-3-mmlu-es:
	lm_eval --model hf --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG) --tasks $(TASK_MMLU_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template

# phi-3 on HELLASWAG_ES
test-phi-3-hellaswag-es:
	lm_eval --model hf --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG) --tasks $(TASK_HELLASWAG_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template

# phi-3 on PSU
test-phi-3-psu:
	lm_eval --model hf --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG) --tasks $(TASK_PSU) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template

# phi-3 on PSU Lenguaje
test-phi-3-psu-lenguaje:
	lm_eval --model hf --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG) --tasks $(TASK_PSU_LENGUAJE) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template

# phi-3 on PSU Historia
test-phi-3-psu-historia:
	lm_eval --model hf --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG) --tasks $(TASK_PSU_HISTORIA) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template
