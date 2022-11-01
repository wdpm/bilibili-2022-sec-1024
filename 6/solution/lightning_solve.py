from time import time

import angr


# https://github.com/angr/angr

def find_flag(known_str, file_path):
    project = angr.Project(file_path)
    simgr = project.factory.simgr()
    # simgr.explore(find=lambda s: known_str in s.posix.dumps(1))
    simgr.explore(find=lambda s: known_str.encode() in s.posix.dumps(1))
    return simgr.found[0].posix.dumps(0)


start = time()
print(find_flag('welcome', './files/EzRe'))
end = time()
print(f'{(end - start)} elapsed.')
# b'superadmin\x80\x00\x00\x00flag6{H97ppy_Bi1i_2233_rE}\x01\x00\x00\x01'
