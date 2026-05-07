#!/bin/bash
set -e

# ==========================================================
# HTML文件日期时间前缀重命名脚本（排除 index.html）
# 格式：
# YYYYMMDDHHMM_filename.html
# 示例：
# 202604052323_mysql-cluster.html
# ==========================================================

TS=$(date +%Y%m%d_%H%M%S)
SRC_DIR="/www/devops-ucloud/ucloud-nav"
BACKUP_DIR="/www/devops-ucloud/ucloud-nav_backup_${TS}"

echo "=================================================="
echo "开始备份目录..."
echo "源目录: ${SRC_DIR}"
echo "备份目录: ${BACKUP_DIR}"
echo "=================================================="

cp -a "${SRC_DIR}" "${BACKUP_DIR}"

echo "开始重命名 HTML 文件（排除 index.html）..."

find "${SRC_DIR}" -maxdepth 1 -type f -name "*.html" ! -name "index.html" | while read -r file; do
    DIRNAME=$(dirname "$file")
    BASENAME=$(basename "$file")

    # 跳过已处理文件
    if [[ "$BASENAME" =~ ^[0-9]{12}_ ]]; then
        echo "跳过已处理文件: ${BASENAME}"
        continue
    fi

    # 优先获取创建时间
    FILE_BIRTH=$(stat -c %w "$file" 2>/dev/null)

    if [[ "$FILE_BIRTH" == "-" || -z "$FILE_BIRTH" ]]; then
        # 如果没有创建时间，则用修改时间
        FILE_DATE=$(date -r "$file" +%Y%m%d%H%M)
    else
        FILE_DATE=$(date -d "$FILE_BIRTH" +%Y%m%d%H%M)
    fi

    NEW_NAME="${DIRNAME}/${FILE_DATE}_${BASENAME}"

    mv "$file" "$NEW_NAME"

    echo "已重命名:"
    echo "  ${BASENAME}"
    echo "  -> $(basename "$NEW_NAME")"
done

echo "=================================================="
echo "✔ 全部处理完成"
echo "✔ index.html 已排除"
echo "✔ 原目录备份位置: ${BACKUP_DIR}"
echo "✔ 文件格式示例: 202604052323_filename.html"
echo "=================================================="
