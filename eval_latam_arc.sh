lm_eval --model hf \
--model_args pretrained=openai-community/gpt2 \
--tasks paes \
--device cuda:6 \
--batch_size 32 \
--output_path outputs \
--log_samples