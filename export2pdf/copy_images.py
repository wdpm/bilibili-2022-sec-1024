import os
import shutil


def makesure_dir_not_exists(dir):
    if os.path.exists(dir):
        shutil.rmtree(dir)


def copy_images(dest):
    for i in range(1, 7 + 1):
        if 1 <= i <= 6:
            src = f"../{i}/docs/assets"
        else:
            src = f"../7-event-egg/docs/assets"

        try:
            # warning: python 3.8+
            shutil.copytree(src, dest, dirs_exist_ok=True)
        except:
            # ignore not exists target assets error
            pass


def merge_markdown_files(md_files):
    all_content = ""
    for idx, md in enumerate(md_files):
        with open(md, 'r', encoding='utf-8') as fp:
            all_content += fp.read()
            all_content += "\r\n" * 2
    return all_content


def read_filenames_to_array():
    with open('includes.txt', 'r', encoding='utf-8') as fp:
        filenames = [line.strip() for line in fp.readlines()]
    return filenames


if __name__ == '__main__':
    dest = 'assets'
    makesure_dir_not_exists(dest)

    copy_images(dest)

    filenames = read_filenames_to_array()
    all_content = merge_markdown_files(filenames)

    merged_file = "merge.md"
    with open(merged_file, 'w', encoding='utf-8') as fp:
        fp.write(all_content)
