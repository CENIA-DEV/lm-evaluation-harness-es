DEVICE=cuda:0
BATCH_SIZE=auto

# models
PHI_2=/home/ouhenio/hf-llms/results/phi-2-continuation/checkpoint-5757
PHI_3=microsoft/Phi-3-mini-128k-instruct
LLAMA_2=meta-llama/Llama-2-7b-chat-hf
LLAMA_3_1=meta-llama/Meta-Llama-3.1-8B-Instruct

# tasks
TASK_MMLU_ES=m_mmlu_es
TASK_HELLASWAG_ES=latam_hellaswag
TASK_PSU=psu
TASK_PSU_LENGUAJE=psu_lenguaje
TASK_PSU_HISTORIA=psu_historia

# model type (hf or vllm)
MODEL_TYPE ?=hf

# cache dir (optional for hf)
CACHE_DIR ?=
ifdef CACHE_DIR
CACHE_ARG=cache_dir=$(CACHE_DIR)
else
CACHE_ARG=
endif

# download dir (optional for vllm)
DOWNLOAD_DIR ?=
ifdef DOWNLOAD_DIR
DOWNLOAD_ARG=download_dir=$(DOWNLOAD_DIR)
else
DOWNLOAD_ARG=
endif

# tensor parallel size (optional for vllm)
TENSOR_PARALLEL_SIZE ?=4
ifeq ($(MODEL_TYPE),vllm)
TENSOR_PARALLEL_ARG=tensor_parallel_size=$(TENSOR_PARALLEL_SIZE)
else
TENSOR_PARALLEL_ARG=
endif

# run all tests
.PHONY: test-all
test-all: test-phi-3-mmlu-es test-phi-2-hellaswag-es test-phi-3-hellaswag-es test-phi-2-psu test-phi-3-psu test-llama-2-mmlu-es test-llama-2-hellaswag-es test-llama-2-psu test-llama-3_1-mmlu-es test-llama-3_1-hellaswag-es test-llama-3_1-psu

###############
# Phi 2 TESTS #
###############

# phi-2 on MMLU-ES
.PHONY: test-phi-2-mmlu-es
test-phi-2-mmlu-es:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(PHI_2),$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_MMLU_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE)


# phi-2 on HELLASWAG_ES
.PHONY: test-phi-2-hellaswag-es
test-phi-2-hellaswag-es:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(PHI_2),$(CACHE_ARG)$(DOWNLOAD_ARG) --tasks $(TASK_HELLASWAG_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE)


# phi-2 on PSU
.PHONY: test-phi-2-psu
test-phi-2-psu:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(PHI_2),$(CACHE_ARG)$(DOWNLOAD_ARG) --tasks $(TASK_PSU) --device $(DEVICE) --batch_size $(BATCH_SIZE)


# phi-2 on PSU Lenguaje
.PHONY: test-phi-2-psu-lenguaje
test-phi-2-psu-lenguaje:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(PHI_2),$(CACHE_ARG)$(DOWNLOAD_ARG) --tasks $(TASK_PSU_LENGUAJE) --device $(DEVICE) --batch_size $(BATCH_SIZE)


# phi-2 on PSU Historia
.PHONY: test-phi-2-psu-historia
test-phi-2-psu-historia:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(PHI_2),$(CACHE_ARG)$(DOWNLOAD_ARG) --tasks $(TASK_PSU_HISTORIA) --device $(DEVICE) --batch_size $(BATCH_SIZE)


###############
# Phi 3 TESTS #
###############

# phi-3 on MMLU-ES
.PHONY: test-phi-3-mmlu-es
test-phi-3-mmlu-es:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_MMLU_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# phi-3 on HELLASWAG_ES
.PHONY: test-phi-3-hellaswag-es
test-phi-3-hellaswag-es:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_HELLASWAG_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# phi-3 on PSU
.PHONY: test-phi-3-psu
test-phi-3-psu:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_PSU) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# phi-3 on PSU Lenguaje
.PHONY: test-phi-3-psu-lenguaje
test-phi-3-psu-lenguaje:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_PSU_LENGUAJE) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# phi-3 on PSU Historia
.PHONY: test-phi-3-psu-historia
test-phi-3-psu-historia:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(PHI_3),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_PSU_HISTORIA) --device $(DEVICE) --batch_size $(BATCH_SIZE)


#################
# LLAMA 2 TESTS #
#################

# llama-2 on MMLU-ES
.PHONY: test-llama-2-mmlu-es
test-llama-2-mmlu-es:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(LLAMA_2),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG),$(TENSOR_PARALLEL_ARG) --tasks $(TASK_MMLU_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# llama-2 on HELLASWAG_ES
.PHONY: test-llama-2-hellaswag-es
test-llama-2-hellaswag-es:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(LLAMA_2),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_HELLASWAG_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# llama-2 on PSU
.PHONY: test-llama-2-psu
test-llama-2-psu:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(LLAMA_2),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_PSU) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# llama-2 on PSU Lenguaje
.PHONY: test-llama-2-psu-lenguaje
test-llama-2-psu-lenguaje:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(LLAMA_2),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_PSU_LENGUAJE) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# llama-2 on PSU Historia
.PHONY: test-llama-2-psu-historia
test-llama-2-psu-historia:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(LLAMA_2),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_PSU_HISTORIA) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


###################
# LLAMA 3.1 TESTS #
###################

# llama-3_1 on MMLU-ES
.PHONY: test-llama-3_1-mmlu-es
test-llama-3_1-mmlu-es:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(LLAMA_3_1),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG),$(TENSOR_PARALLEL_ARG) --tasks $(TASK_MMLU_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# llama-3_1 on HELLASWAG_ES
.PHONY: test-llama-3_1-hellaswag-es
test-llama-3_1-hellaswag-es:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(LLAMA_3_1),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_HELLASWAG_ES) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# llama-3_1 on PSU
.PHONY: test-llama-3_1-psu
test-llama-3_1-psu:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(LLAMA_3_1),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_PSU) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# llama-3_1 on PSU Lenguaje
.PHONY: test-llama-3_1-psu-lenguaje
test-llama-3_1-psu-lenguaje:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(LLAMA_3_1),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_PSU_LENGUAJE) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template


# llama-3_1 on PSU Historia
.PHONY: test-llama-3_1-psu-historia
test-llama-3_1-psu-historia:
	lm_eval --model $(MODEL_TYPE) --model_args pretrained=$(LLAMA_3_1),trust_remote_code=True,$(CACHE_ARG)$(DOWNLOAD_ARG)$(TENSOR_PARALLEL_ARG) --tasks $(TASK_PSU_HISTORIA) --device $(DEVICE) --batch_size $(BATCH_SIZE) --apply_chat_template
