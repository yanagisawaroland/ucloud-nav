cat > /www/devops-ucloud/ucloud-nav/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!-- 禁止DNS预解析、禁用外部链接预取、强制缓存 -->
<meta http-equiv="X-DNS-Prefetch-Control" content="off">
<meta http-equiv="Cache-Control" content="max-age=86400">
<style>
body { text-align: center; font-size: 28px; line-height: 2.2; margin-top: 30px; }
a { text-decoration: none; color: #0066cc; display: block; margin: 8px 0; }
a:hover { color: #0099ff; }
</style>
</head>
<body>
EOF
ls /www/devops-ucloud/ucloud-nav/*.html | grep -v index.html | xargs -n1 basename | awk '{print "<a href=\""$0"\">"$0"</a>"}' >> /www/devops-ucloud/ucloud-nav/index.html
cat >> /www/devops-ucloud/ucloud-nav/index.html <<'EOF'
</body>
</html>
EOF
