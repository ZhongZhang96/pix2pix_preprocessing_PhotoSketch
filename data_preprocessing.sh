dataDir= # YOUR_DIRECTORY
pix2pix_env=tf1 # Yor Pixel2Pixel environment name
PhotoSketch_env=sketch # Your PhotoSketch environment name

python rename.py --image_dir ${dataDir}

source activate ${pix2pix_env}

python process.py \
    --input_dir ${dataDir}/original \
    --operation resize \
    --pad white \
    --output_dir ${dataDir}/resized

conda deactivate
source activate ${PhotoSketch_env}

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
source activate ${pix2pix_env}

python process.py \
     --input_dir ${dataDir}/Sketch \
     --b_dir ${dataDir}/resized \
     --operation combine \
     --output_dir ${dataDir}/combined

conda deactivate
