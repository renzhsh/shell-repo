import files
import xmls
import os
import re

workdir = "E:\jenkins_home\jobs"
ip = '192.168.200.52'
cluster = 'NEW-LMKJ-DEV-TEST'
new_ip = '192.168.100.141'
new_access_key = "75t78h4fmsx4.ay2hybybny6h8afrbfpsst8md4k7bhfm"

def text_replace(text):
    if text.find(ip) > -1 and text.find(cluster) > -1:
        text = text.replace(ip, new_ip)
        pattern = r'KuboardAccessKey=([a-zA-Z0-9.]+)'
        text = re.sub(pattern, f'KuboardAccessKey={new_access_key}', text)
        return True, text
    else:
        return False, text


def exec_replace(file, text):
    valid, new_text = text_replace(text)
    if valid:
        files.copy(file, file + ".backup")
        xmls.modify_node(file,"KuboardUsername",new_text)
        print(f"{file} 替换成功")

def exec_job(job):
    file_name = job + "/config.xml"
    if os.path.exists(file_name):
        print(job + " 未执行")
    else:
        return
    valid, text = xmls.find_shell(file_name, "KuboardUsername")
    if valid:
        exec_replace(file_name, text)
    else:
        print(job + " 未执行")


# jenkins_jobs = files.find_dirs(workdir)
# for job in jenkins_jobs:
#     exec_job(job)

exec_job(f"{workdir}/Dev-小靓马SaaS平台-platform-micro")
