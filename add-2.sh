#!/bin/bash
DIR="/www/devops-ucloud/ucloud-nav"
INDEX="$DIR/index.html"

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
.row {
    display: flex;
    flex-wrap: wrap;
    gap: 40px;
    margin-bottom: 20px;
}
.row a {
    display: inline-block;
    padding: 0;
    line-height: 2.8;
}
</style>
</head>
<body>
<div class="container">
<h1>服务文档导航</h1>

<!-- 0 开头文件：横排 -->
<div class="row">
HTML

cd "$DIR"

# 生成 0 开头横排
for file in 0*.html; do
    if [ -f "$file" ] && [ "$file" != "index.html" ]; then
        echo "<a href=\"./$file\">$file</a>" >> "$INDEX"
    fi
done

# 关闭横排区域
echo "</div>" >> "$INDEX"

# 生成 非0 开头竖排（原样）
for file in *.html; do
    if [[ "$file" != 0*.html && "$file" != "index.html" && -f "$file" ]]; then
        echo "<a href=\"./$file\">$file</a>" >> "$INDEX"
    fi
done

echo "</div></body></html>" >> "$INDEX"

echo "✅ index.html 已生成完成！"
echo "📍 路径：$INDEX"
