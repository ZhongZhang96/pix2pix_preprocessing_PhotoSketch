# pix2pix_preporcessing_PhotoSketch

## 准备工作
1. 一个可以运行Pixel2Pixel的conda环境，要求见https://github.com/affinelayer/pix2pix-tensorflow

2. 一个可以运行PhotoSketch的conda环境，要求见https://github.com/mtli/PhotoSketch, 或运行`conda env create -f PhotoSketch_environment.yml` 自动安装

3. 一个装有图片的文件夹，命名为`raw`

## 运行程序
1. 修改`data_preprocessing.sh`中的参数，其中：
- `dataDir`为`raw`文件夹的父目录
- `pix2pix_env`为Pixel2Pixel环境的命名
- `PhotoSketch_env`为PhotoSketch环境的命名

2. 运行`data_preprocessing.sh`

## 程序结果
程序会在`raw`所在的目录创建4个文件夹：`original`, `resized`, `Sketch`, `combined`

1. `original`为脚本`rename.py`输出的结果，其主要功能为：
- 删除无法打开的损坏文件
- 将RGBA和灰度图像转化为RGB图像
- 将透明背景的png图像转换为白色背景的jpg图像
- 最后将图像重命名为编号格式

2. `resized`为脚本`process.py`的输出结果，其将图片用白色背景补齐为正方形，并缩小为指定大小

3. `Sketch`为脚本`test_pretrained.py`的输出结果，其利用预训练的PhotoSketch网络，提取图片轮廓

3. `combined`为脚本`process.py`的输出结果，其将`Sketch`和`resized`的结果组合，作为最终的训练数据
