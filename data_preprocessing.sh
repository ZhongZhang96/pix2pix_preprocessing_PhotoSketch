dataDir=

source activate tf1

python process.py \
    --input_dir ${dataDir}/original \
    --operation resize \
    --output_dir ${dataDir}/resized

conda deactivate
source activate sketch

python test_pretrained.py \
    --name pretrained \
    --dataset_mode test_dir \
    --dataroot ${dataDir}/resized/ \
    --results_dir ${dataDir}/Sketch/ \
    --checkpoints_dir Exp/PhotoSketch/Checkpoints/ \
    --model pix2pix \
    --which_direction AtoB \
    --norm batch \
    --input_nc 3 \
    --output_nc 1 \
    --which_model_netG resnet_9blocks \
    --no_dropout \

conda deactivate
source activate tf1

python process.py \
     --input_dir ${dataDir}/Sketch \
     --b_dir ${dataDir}/resized \
     --operation combine \
     --output_dir ${dataDir}/combined

conda deactivate
