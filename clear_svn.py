#!/usr/bin/env python
#-*- coding:utf-8 -*-
__author__ = 'ashin'

import os, stat

def del_files(path):
    '''
    清空.svn文件夹内所有文件，并删除清空后的空文件夹
    '''
    files = os.listdir(path)
    for f in files:
        f_path = os.path.join(path, f)
        if os.path.isfile(f_path):
            os.chmod(f_path, stat.S_IWRITE) #有些只读文件没法删，要修改权限
            os.remove(f_path)
            print '---removed %s'%f_path
        elif os.path.isdir(f_path):
            #递归清空文件夹并删除
            del_files(f_path)
            os.rmdir(f_path)


def clear_svn(path):
    '''
    清空给定路径下的所有.svn文件夹
    '''
    for path, subdirs, files in os.walk(path):
        if '.svn' in subdirs:
            svn_path = os.path.join(path, '.svn')
            del_files(svn_path)
            try:
                #会首先删除根目录的.svn，但是此时不是空文件夹，无法删除
                os.rmdir(svn_path)
                print 'removed %s'%svn_path
            except:
                pass

if __name__ == '__main__':
    clear_svn('.')  #清空当前目录下所有.svn
