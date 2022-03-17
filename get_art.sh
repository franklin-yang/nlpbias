#!/bin/bash
#SBATCH --job-name=bash
##SBATCH --qos=batch
#SBATCH --qos=gpu-medium
#SBATCH --partition=gpu
##Next lines requeset specific GPU type or just any GPU, respectively
#SBATCH --gres=gpu:gtx1080ti:1
##Use -n to request number of cpus per task 
#SBATCH -n 1
#SBATCH --mem=200gb
#SBATCH --time=4:00:00

cd /fs/clip-quiz/flatearf/nlpbias/retrieval-based-baselines
conda activate py36
python3 run_inference.py  --qa_file /fs/clip-quiz/flatearf/nlpbias/qs.json --retrieval_type dpr --db_path ${base_dir}/data/wikipedia_split/psgs_w100.tsv   --dpr_model_file ${dpr_retrieval_checkpoint}  --dense_index_path ${dpr_index}  --model_file ${reader_checkpoint}  --dev_batch_size 8 --pretrained_model_cfg bert-base-uncased --encoder_model_type hf_bert --do_lower_case --sequence_length 350 --eval_top_docs 10 --passages_per_question_predict 40 --prediction_results_file dev_predictions.json 