#!/usr/bin/env python3

import argparse
import os
import shutil
import stat
import sys
import uuid

import requests
from git import Repo
from requests.auth import HTTPDigestAuth


def copytree(src, dst, symlinks=False, ignore=None):
    if not os.path.exists(dst):
        os.makedirs(dst)
        shutil.copystat(src, dst)
    lst = os.listdir(src)
    if ignore:
        excl = ignore(src, lst)
        lst = [x for x in lst if x not in excl]
    for item in lst:
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if symlinks and os.path.islink(s):
            if os.path.lexists(d):
                os.remove(d)
            os.symlink(os.readlink(s), d)
            try:
                st = os.lstat(s)
                mode = stat.S_IMODE(st.st_mode)
                os.lchmod(d, mode)
            except:
                pass  # lchmod not available
        elif os.path.isdir(s):
            copytree(s, d, symlinks, ignore)
        else:
            shutil.copy2(s, d)


def argv_parser():
    prs = argparse.ArgumentParser()
    prs.add_argument("-m", "--message", default="Admin fix")
    prs.add_argument("-s", "--source", default="src")
    prs.add_argument("-d", "--destination", default="dst")
    prs.add_argument("-r", "--repo", default="work")
    prs.add_argument("--master", default="main")

    return prs


parser = argv_parser()
ns = parser.parse_args(sys.argv[1:])

username = "arhipovea"
token = "token"
repo_path = ns.destination
repo_name = ns.repo
src_path = ns.source
remote_url = f"git@github.com:{username}/{repo_name}.git"
remote_branch = ns.master
new_branch = f"{username}_{uuid.uuid4().hex[:8]}"
commit_message = ns.message

# Local git
if os.path.exists(repo_path):
    repo = Repo(repo_path)
else:
    repo = Repo.clone_from(remote_url, repo_path, branch=remote_branch)

git = repo.git
git.checkout("HEAD", b=new_branch)
copytree(src_path, repo_path)
if repo.is_dirty(untracked_files=True):
    print("Repo is dirty")
    git.add("--all")
    git.commit(m=commit_message)
    git.push("--set-upstream", "origin", new_branch)

# Remote api pull request
url = f"https://api.github.com/repos/{username}/{repo_name}/pulls"
headers = {"Accept": "application/vnd.github.v3+json"}
payload = {"head": f"{new_branch}", "base": f"{remote_branch}"}
auth = HTTPDigestAuth(username, token)
requests.post(url, headers=headers, data=payload, auth=auth)

# shutil.rmtree(repo_path)
