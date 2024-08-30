import os
import shutil


def find_dirs(directory):
    items = []
    for root, dirs, files in os.walk(directory):
        for name in dirs:
            items.append(os.path.join(root, name))
    return items


def copy(src, dest):
    try:
        shutil.copy(src, dest)
    except IOError as e:
        print(f"无法复制文件: {e}")
