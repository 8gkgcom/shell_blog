详细的帮助文档：

```markdown
# 静态博客生成器使用说明

## 简介

这是一个轻量级的静态博客生成器，使用 Bash 脚本将 Markdown 文件转换为美观的静态 HTML 博客网站。生成的博客具有响应式设计，适配各种设备。

## 系统要求

### 必需软件
- **Linux/macOS 系统** 或 **Windows WSL**
- **Bash Shell** (通常系统自带)
- **基本 Unix 工具**: `stat`, `date`, `basename` (通常系统自带)

### 可选软件
- **Pandoc** (推荐安装，用于更好的 Markdown 转 HTML)
  - 如果未安装，脚本会将 Markdown 内容以纯文本形式显示

## 安装 Pandoc (可选但推荐)

### Ubuntu/Debian
```bash
sudo apt update
sudo apt install pandoc
```

### CentOS/RHEL/Fedora
```bash
# CentOS/RHEL
sudo yum install pandoc
# 或 Fedora
sudo dnf install pandoc
```

### macOS
```bash
# 使用 Homebrew
brew install pandoc

# 或使用 MacPorts
sudo port install pandoc
```

### Windows (WSL)
```bash
sudo apt update
sudo apt install pandoc
```

## 快速开始

### 1. 下载脚本
将博客生成脚本保存为 `generate_blog.sh`：

```bash
# 下载或创建脚本文件
nano generate_blog.sh
# 将脚本内容粘贴到文件中，然后保存
```

### 2. 设置执行权限
```bash
chmod +x generate_blog.sh
```

### 3. 创建第一篇文章
```bash
# 创建 Markdown 文件目录
mkdir -p md

# 创建第一篇文章
cat > md/hello-world.md << 'EOF'
# 你好，世界！

这是我的第一篇博客文章。

## 关于 Markdown

Markdown 是一种轻量级标记语言，你可以使用它来格式化文本。

### 一些基本语法：

- **粗体文本**
- *斜体文本*
- `代码片段`

#### 代码块示例：

```bash
echo "Hello, World!"
```

#### 引用示例：

> 这是一个引用块。
> 可以用来突出重要内容。

#### 列表示例：

1. 第一项
2. 第二项
3. 第三项

- 无序列表项1
- 无序列表项2
- 无序列表项3
EOF
```

### 4. 生成博客
```bash
./generate_blog.sh
```

### 5. 查看博客
```bash
# 在浏览器中打开生成的博客
# Linux
xdg-open html/index.html

# macOS
open html/index.html

# Windows WSL
explorer.exe html/index.html
```

## 目录结构

```
项目根目录/
├── generate_blog.sh    # 博客生成脚本
├── md/                 # Markdown 文件目录
│   ├── article1.md
│   ├── article2.md
│   └── ...
└── html/              # 生成的博客网站 (自动创建)
    ├── index.html     # 博客首页
    ├── about.html     # 关于页面
    ├── assets/        # 样式和脚本文件
    │   ├── style.css
    │   └── blog.js
    └── posts/         # 文章页面
        ├── 2024-01-01-article1.html
        ├── 2024-01-02-article2.html
        └── ...
```

## 使用指南

### 添加新文章

1. 在 `md/` 目录中创建新的 `.md` 文件
2. 使用 Markdown 语法编写文章内容
3. 运行 `./generate_blog.sh` 重新生成博客

```bash
# 示例：创建新文章
cat > md/my-second-post.md << 'EOF'
# 我的第二篇文章

这里是文章内容...
EOF

# 重新生成博客
./generate_blog.sh
```

### 修改现有文章

1. 编辑 `md/` 目录中对应的 `.md` 文件
2. 运行 `./generate_blog.sh` 重新生成博客

```bash
# 编辑现有文章
nano md/hello-world.md

# 重新生成博客
./generate_blog.sh
```

### 自定义博客信息

编辑脚本中的以下部分来自定义博客信息：

```bash
# 在脚本中找到这些行并修改
<title>我的博客</title>                    # 修改博客标题
<h1><a href="index.html">我的博客</a></h1>  # 修改博客名称
<p>&copy; $(date +%Y) 个人博客.</p>        # 修改版权信息
```

### 自定义样式

你可以修改生成的 `html/assets/style.css` 文件来自定义博客外观：

```bash
# 备份原始样式
cp html/assets/style.css html/assets/style.css.backup

# 编辑样式文件
nano html/assets/style.css
```

注意：重新运行脚本会覆盖自定义样式，建议修改脚本中的CSS部分。

## Markdown 语法参考

### 标题
```markdown
# 一级标题
## 二级标题
### 三级标题
```

### 文本格式
```markdown
**粗体文本**
*斜体文本*
`行内代码`
~~删除线~~
```

### 链接和图片
```markdown
[链接文本](http://example.com)
![图片描述](image-url.jpg)
```

### 列表
```markdown
# 无序列表
- 项目1
- 项目2

# 有序列表
1. 第一项
2. 第二项
```

### 代码块
````markdown
```语言名称
代码内容
```
````

### 引用
```markdown
> 这是引用文本
> 可以多行
```

### 表格
```markdown
| 列1 | 列2 | 列3 |
|-----|-----|-----|
| 内容1 | 内容2 | 内容3 |
```

## 部署博客

### 本地查看
生成的博客在 `html/` 目录中，可以直接用浏览器打开 `index.html`。

### 部署到服务器
将 `html/` 目录的所有内容上传到你的 Web 服务器即可。

```bash
# 示例：使用 rsync 部署到服务器
rsync -avz html/ user@your-server.com:/var/www/html/
```

### 部署到 GitHub Pages
1. 将 `html/` 目录内容推送到 GitHub 仓库
2. 在仓库设置中启用 GitHub Pages
3. 选择主分支作为发布源

## 故障排除

### 常见问题

**Q: 运行脚本时提示权限被拒绝**
```bash
# 解决方法：设置执行权限
chmod +x generate_blog.sh
```

**Q: Markdown 文件没有被正确转换**
```bash
# 检查 Pandoc 是否安装
pandoc --version

# 如果未安装，参考上面的安装说明
```

**Q: 生成的文章没有显示在首页**
```bash
# 检查文件是否在正确位置
ls -la md/

# 确保文件以 .md 结尾
# 重新运行脚本
./generate_blog.sh
```

**Q: 样式没有加载**
```bash
# 检查文件结构
ls -la html/
ls -la html/assets/

# 确保 CSS 和 JS 文件存在
```

### 调试模式
在脚本开头添加调试选项：

```bash
#!/bin/bash
set -x  # 添加这行来启用调试模式
```

## 高级配置

### 自定义文件排序
默认按文件修改时间排序。如果要按文件名排序，修改脚本中的排序部分：

```bash
# 找到这行
IFS=$'\n' sorted_posts=($(printf "%s\n" "${POSTS_ARRAY[@]}" | sort -t"|" -k1 -nr))

# 改为按标题排序
IFS=$'\n' sorted_posts=($(printf "%s\n" "${POSTS_ARRAY[@]}" | sort -t"|" -k2))
```

### 添加更多页面
可以在脚本中添加更多静态页面的生成逻辑，类似 `about.html` 的创建方式。

## 许可证

本脚本为开源软件，你可以自由使用、修改和分发。

## 贡献

欢迎提交问题报告和改进建议！

---

**个人的使用经验**
```

将脚本放在www目录下，新建一个md文件夹，和ai的大部分对话可以直接导出md格式的文件，把md文件放到md文件夹内，执行boke.sh生成博客页面。
更新md内容后重新运行脚本即可更新博客，个人信息需要修改boke.sh源码。
