import xml.etree.ElementTree as ET


def find_shell(file_name, keyword):
    tree = ET.parse(file_name)

    shells = tree.findall('.//hudson.tasks.Shell')
    for shell in shells:
        _text = shell.find('command').text
        if _text.find(keyword) > 0:
            return True, _text

    return False, ''


def modify_node(file_name, keyword, content):
    tree = ET.parse(file_name)

    shells = tree.findall('.//hudson.tasks.Shell')
    for shell in shells:
        command = shell.find('command')
        if command.text.find(keyword) > 0:
            command.text = content
            break

    tree.write(file_name, encoding='utf-8', xml_declaration=True)

    return True
