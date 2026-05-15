#!/bin/bash
DIR="/www/devops-ucloud/ucloud-nav"
INDEX="$DIR/index.html"

# 生成 index.html （美观样式 + 相对路径链接）
cat > "$INDEX" <<'HTML'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>服务导航页</title>
<style>
body {
    background: #f5f7fa;
    font-family: "Microsoft YaHei", Arial;
    padding: 50px 20px;
}
.container {
    max-width: 1200px;
    margin: 0 auto;
    text-align: left;
}
h1 {
    text-align: center;
    font-size: 32px;
    margin-bottom: 40px;
    color: #2c3e50;
}
a {
    display: block;
    font-size: 24px;
    line-height: 2.8;
    color: #005cc5;
    text-decoration: none;
    padding: 8px 0;
}
a:hover {
    color: #032f62;
    font-weight: bold;
}
</style>
</head>
<body>
<div class="container">
<h1>服务文档导航</h1>
HTML

# 自动添加所有 html 文件（相对路径）
cd "$DIR"
for file in *.html; do
    if [ -f "$file" ] && [ "$file" != "index.html" ]; then
        echo "<a href="./$file">$file</a>" >> "$INDEX"
    fi
done

# 闭合 HTML
echo "</div></body></html>" >> "$INDEX"

echo "✅ index.html 已生成完成！"
echo "📍 路径：$INDEX"
