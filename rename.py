import os
from PIL import Image
import argparse


parser = argparse.ArgumentParser()
parser.add_argument("--image_dir", help="path to folder containing images")
a = parser.parse_args()
path = a.image_dir
input_path = path+os.sep+'raw'+os.sep
output_path = path+os.sep+'original'+os.sep
if not os.path.exists(output_path):
    os.mkdir(output_path)


def IsValidImage(img_path):
    """
    判断文件是否为有效（完整）的图片
    :param img_path:图片路径
    :return:True：有效 False：无效
    """
    bValid = True
    try:
        Image.open(img_path).verify()
    except:
        bValid = False
    return bValid


def transimg(img_path, output_img_path):
    """
    转换图片格式
    :param img_path:图片路径
    :return: True：成功 False：失败
    """
    if IsValidImage(img_path):
        # try:
        #     im = Image.open(img_path)
        #     background = Image.new('RGBA', im.size, (255, 255, 255))
        #     # Paste the image on top of the background
        #     background.paste(im, im)
        #     im = background
        #     im = im.convert('RGB')
        #     im.save(output_img_path)
        #     return True
        # except:
        #     return False
        im = Image.open(img_path)
        background = Image.new('RGBA', im.size, (255, 255, 255))
        # Paste the image on top of the background
        im = im.convert('RGBA')
        background.paste(im, im)
        im = background.convert('RGB')
        im.save(output_img_path)
        return True
    else:
        return False


if __name__ == "__main__":  
    #获取该目录下所有文件，存入列表中
    fileList=os.listdir(input_path)

    n=0
    for i in fileList:
        
        #设置旧文件名（就是路径+文件名）
        oldname=input_path+i   # os.sep添加系统分隔符
        
        #设置新文件名
        newname=output_path+str(n).zfill(3)+'.jpg'

        if not transimg(oldname, newname):
            try:
                os.remove(newname)
            except:
                pass
            n = n-1
        else:
            print(oldname,'======>',newname)
        n+=1