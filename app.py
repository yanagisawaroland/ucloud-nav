#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from http.server import HTTPServer, SimpleHTTPRequestHandler
import os

# 数据文件固定路径
MEMO_FILE = "/www/devops-ucloud/ucloud-nav/memo-data.txt"

class MyHandler(SimpleHTTPRequestHandler):
    # 读取备忘录
    def do_GET(self):
        if self.path == "/memo-load":
            self.send_response(200)
            self.send_header("Content-Type", "text/plain; charset=utf-8")
            self.end_headers()
            text = ""
            if os.path.exists(MEMO_FILE):
                with open(MEMO_FILE, "r", encoding="utf-8") as f:
                    text = f.read()
            self.wfile.write(text.encode("utf-8"))
            return
        # 其它静态文件(html/css/js) 正常访问
        super().do_GET()

    # 保存备忘录
    def do_POST(self):
        if self.path == "/memo-save":
            self.send_response(200)
            self.end_headers()
            length = int(self.headers.get("Content-Length", 0))
            content = self.rfile.read(length).decode("utf-8")
            with open(MEMO_FILE, "w", encoding="utf-8") as f:
                f.write(content)
            return

if __name__ == "__main__":
    os.chdir("/www/devops-ucloud/ucloud-nav/")
    server = HTTPServer(("0.0.0.0", 7777), MyHandler)
    print("运行目录：/www/devops-ucloud/ucloud-nav/")
    print("服务：0.0.0.0:7777")
    server.serve_forever()
