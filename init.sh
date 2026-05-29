#!/bin/bash

# XJTU-thesis 初始化脚本
# 用于准备必要的字体资源文件，确保项目自包含

set -e

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "=============================================="
echo "  XJTU-thesis 项目初始化"
echo "=============================================="
echo ""

FONT_DIR="font"

# 创建字体目录
if [ ! -d "$FONT_DIR" ]; then
    mkdir -p "$FONT_DIR"
    echo -e "${GREEN}✓${NC} 创建字体目录: $FONT_DIR"
else
    echo -e "${YELLOW}!${NC} 字体目录已存在: $FONT_DIR"
fi

echo ""
echo "----------------------------------------------"
echo "  检查系统字体并复制到本地"
echo "----------------------------------------------"
echo ""

# 中文字体：思源宋体 (Noto Serif CJK SC) 替代 SimSun
copy_font() {
    local src="$1"
    local dst="$2"
    if [ -f "$src" ]; then
        cp "$src" "$dst"
        echo -e "${GREEN}✓${NC} 复制: $(basename "$src") → $dst"
        return 0
    else
        echo -e "${RED}✗${NC} 未找到: $src"
        return 1
    fi
}

# 复制中文字体
echo "【中文字体】"
copy_font "/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc" "$FONT_DIR/NotoSerifCJK-Regular.ttc" || true
copy_font "/usr/share/fonts/opentype/noto/NotoSerifCJK-Bold.ttc" "$FONT_DIR/NotoSerifCJK-Bold.ttc" || true
copy_font "/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc" "$FONT_DIR/NotoSansCJK-Regular.ttc" || true
copy_font "/usr/share/fonts/opentype/noto/NotoSansCJK-Bold.ttc" "$FONT_DIR/NotoSansCJK-Bold.ttc" || true

# 英文字体：Nimbus Roman (Times New Roman 的开源替代)
echo ""
echo "【英文字体】"
copy_font "/usr/share/fonts/opentype/urw-base35/NimbusRoman-Regular.otf" "$FONT_DIR/NimbusRoman-Regular.otf" || true
copy_font "/usr/share/fonts/opentype/urw-base35/NimbusRoman-Bold.otf" "$FONT_DIR/NimbusRoman-Bold.otf" || true
copy_font "/usr/share/fonts/opentype/urw-base35/NimbusRoman-Italic.otf" "$FONT_DIR/NimbusRoman-Italic.otf" || true
copy_font "/usr/share/fonts/opentype/urw-base35/NimbusRoman-BoldItalic.otf" "$FONT_DIR/NimbusRoman-BoldItalic.otf" || true

echo ""
echo "----------------------------------------------"
echo "  字体文件清单"
echo "----------------------------------------------"
echo ""

if [ -d "$FONT_DIR" ] && [ "$(ls -A "$FONT_DIR")" ]; then
    ls -lh "$FONT_DIR" | awk '{print "  " $9 " \t" $5}'
else
    echo -e "${RED}  警告: 未找到任何字体文件${NC}"
fi

echo ""
echo "=============================================="
echo -e "${GREEN}  初始化完成！${NC}"
echo "=============================================="
echo ""
echo "提示: 如果某些字体未找到，请确保系统已安装相应字体包:"
echo "  - noto-cjk: sudo apt install fonts-noto-cjk"
echo "  - urw-base35: sudo apt install fonts-urw-base35"
echo ""
