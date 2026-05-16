# GitHub 推送被 Secret 扫描拦截的解决办法

## 背景

本地仓库绑定了三个远程仓库：GitLab、Gitee、GitHub。推送到 GitLab 和 Gitee 正常，推送到 GitHub 时被拦截。

## 报错信息

git push github main 后返回：

remote: error: GH013: Repository rule violations found for refs/heads/main.
remote: - GITHUB PUSH PROTECTION
remote:   Push cannot contain secrets
remote:   —— GitLab Access Token
remote:   locations:
remote:     - commit: xxxx path: 0.0.0.gitee-gitlab.html:38
remote:     - commit: xxxx path: 0.0.0.harbor-gitlab.html:23
remote:   (?) To push, remove secret from commit(s) or follow this URL to allow the secret.
remote:   https://github.com/组织/仓库/security/secret-scanning/unblock-secret/...

## 问题原因

HTML 文件中直接写入了 GitLab 的 PRIVATE-TOKEN（glpat-xxx）和 Harbor 的密码（Harbor12345）。GitHub 自动扫描检测到这些敏感信息，拒绝推送。

## 解决方案

### 方案一：允许 Secret（推荐，最快捷）

复制 GitHub 返回的 unblock-secret 链接，在浏览器打开，点击 Allow secret。然后重新推送即可。

### 方案二：删除敏感信息并重写历史

1. 替换当前文件中的敏感信息

sed -i 's/glpat-m9iZ4vhjr-JssshmkpdT/你的GitLabToken/g' 文件名.html
sed -i 's/Harbor12345/你的Harbor密码/g' 文件名.html

2. 提交并推送

git add -A
git commit -m "移除敏感信息"
git push github main

## 注意事项

如果旧 commit 中已有敏感信息，即使当前文件替换了，GitHub 仍会扫描到历史记录中的内容。此时需要用 git filter-branch 或 BFG 工具重写整个 git 历史，或者用方案一允许通过。
