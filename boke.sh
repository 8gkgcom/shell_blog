#!/bin/bash

# 设置源文件夹（存放 Markdown 文件的文件夹）
SOURCE_DIR="./md"

# 设置博客的根目录
BLOG_DIR="./html"

# 设置文章存放的目录
POSTS_DIR="${BLOG_DIR}/posts"

# 设置资产存放目录
ASSETS_DIR="${BLOG_DIR}/assets"

# 设置首页文件路径
INDEX_FILE="${BLOG_DIR}/index.html"

# 设置"关于我"页面路径
ABOUT_FILE="${BLOG_DIR}/about.html"

# 确认源文件夹存在
if [ ! -d "$SOURCE_DIR" ]; then
    mkdir -p "$SOURCE_DIR"
    echo "警告: 源文件夹不存在，已创建空的源文件夹。请添加Markdown文件到 $SOURCE_DIR 目录。"
fi

# 创建必要的目录（如果不存在）
mkdir -p "$POSTS_DIR"
mkdir -p "$ASSETS_DIR"

echo "开始生成博客..."

# 创建并写入简化的 style.css
cat <<'EOL' > "${ASSETS_DIR}/style.css"
/* 全局样式 */
:root {
    --primary-color: #2c3e50;
    --secondary-color: #3498db;
    --accent-color: #1abc9c;
    --text-light: #ffffff;
    --text-dark: #2c3e50;
    --background-light: #f8f9fa;
    --card-bg: #ffffff;
    --card-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    --border-color: #e9ecef;
}

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    line-height: 1.6;
    color: var(--text-dark);
    background-color: var(--background-light);
}

.container {
    width: 90%;
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px 0;
}

/* 顶部导航 */
header {
    background-color: var(--primary-color);
    color: var(--text-light);
    padding: 20px 0;
    box-shadow: var(--card-shadow);
}

header .container {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding-top: 10px;
    padding-bottom: 10px;
}

header h1 {
    margin-bottom: 15px;
    font-size: 2rem;
    font-weight: 600;
    color: var(--text-light);
}

header h1 a {
    color: inherit;
    text-decoration: none;
}

nav {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 20px;
}

nav a {
    color: var(--text-light);
    text-decoration: none;
    font-size: 1rem;
    font-weight: 500;
    padding: 8px 16px;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

nav a:hover {
    background-color: rgba(255, 255, 255, 0.1);
}

/* 主内容区域 */
main {
    padding: 40px 0;
    min-height: calc(100vh - 200px);
}

main h2 {
    margin-bottom: 30px;
    font-size: 1.8rem;
    color: var(--primary-color);
    border-bottom: 2px solid var(--accent-color);
    padding-bottom: 10px;
}

/* 文章列表 */
.posts-grid {
    display: flex;
    flex-direction: column;
    gap: 15px;
    margin-top: 30px;
}

.post {
    background: var(--card-bg);
    border: 1px solid var(--border-color);
    border-radius: 8px;
    padding: 20px;
    transition: box-shadow 0.3s ease, transform 0.2s ease;
}

.post:hover {
    box-shadow: var(--card-shadow);
    transform: translateY(-2px);
}

.post-inner {
    display: flex;
    align-items: center;
    gap: 15px;
}

.post-icon {
    font-size: 1.5rem;
    color: var(--accent-color);
    width: 40px;
    text-align: center;
    flex-shrink: 0;
}

.post-content {
    flex: 1;
    min-width: 0;
}

.post h3 {
    margin-bottom: 5px;
    font-size: 1.2rem;
    color: var(--primary-color);
    line-height: 1.4;
}

.post h3 a {
    color: inherit;
    text-decoration: none;
    transition: color 0.3s ease;
}

.post h3 a:hover {
    color: var(--secondary-color);
}

.post-meta {
    font-size: 0.9rem;
    color: #666;
    display: flex;
    align-items: center;
    gap: 5px;
}

.post-actions {
    display: flex;
    align-items: center;
    flex-shrink: 0;
}

.post .read-more {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 8px 16px;
    background: var(--secondary-color);
    color: white;
    border-radius: 4px;
    font-size: 0.9rem;
    text-decoration: none;
    transition: background-color 0.3s ease;
}

.post .read-more:hover {
    background: var(--primary-color);
}

/* 无文章提示样式 */
.no-posts {
    background: var(--card-bg);
    border: 1px solid var(--border-color);
    border-radius: 8px;
    padding: 40px;
    text-align: center;
    margin-top: 30px;
}

.no-posts h3 {
    font-size: 1.5rem;
    margin-bottom: 15px;
    color: var(--primary-color);
}

.no-posts p {
    color: #666;
    margin-bottom: 20px;
}

.no-posts .hint {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 4px;
    margin-top: 20px;
    text-align: left;
    font-family: monospace;
    font-size: 0.9rem;
}

/* 文章内容页 */
.post-header {
    margin-bottom: 30px;
    padding-bottom: 15px;
    border-bottom: 1px solid var(--border-color);
}

.post-content {
    line-height: 1.8;
    color: #444;
}

.post-content p {
    margin-bottom: 1.5rem;
}

.post-content h1, 
.post-content h2, 
.post-content h3, 
.post-content h4 {
    margin: 2rem 0 1rem;
    color: var(--primary-color);
    line-height: 1.4;
}

.post-content ul, 
.post-content ol {
    margin-bottom: 1.5rem;
    padding-left: 2rem;
}

.post-content li {
    margin-bottom: 0.5rem;
}

.post-content code {
    background-color: #f8f9fa;
    padding: 0.2em 0.4em;
    border-radius: 3px;
    font-family: 'Courier New', monospace;
    font-size: 0.9em;
}

.post-content pre {
    background-color: #f8f9fa;
    padding: 1rem;
    border-radius: 4px;
    overflow-x: auto;
    margin-bottom: 1.5rem;
    border: 1px solid var(--border-color);
}

.post-content blockquote {
    border-left: 3px solid var(--secondary-color);
    padding: 0.5rem 1rem;
    margin: 1.5rem 0;
    color: #555;
    background: #f8f9fa;
    border-radius: 0 4px 4px 0;
}

.back-link {
    display: inline-block;
    margin-top: 30px;
    color: var(--secondary-color);
    text-decoration: none;
    font-weight: 500;
    padding: 10px 20px;
    border: 1px solid var(--secondary-color);
    border-radius: 4px;
    transition: all 0.3s ease;
}

.back-link:hover {
    color: white;
    background: var(--secondary-color);
}

/* 页脚 */
footer {
    background-color: var(--primary-color);
    color: var(--text-light);
    text-align: center;
    padding: 30px 0;
    margin-top: 40px;
}

footer p {
    font-size: 0.9rem;
    opacity: 0.9;
}

/* 关于页面样式 */
.about-content {
    background: var(--card-bg);
    border: 1px solid var(--border-color);
    border-radius: 8px;
    padding: 40px;
    max-width: 700px;
    margin: 0 auto;
}

.about-content h2 {
    margin-top: 0;
    margin-bottom: 20px;
}

.about-content h3 {
    margin-top: 30px;
    margin-bottom: 15px;
    color: var(--primary-color);
}

.about-content p, 
.about-content ul {
    margin-bottom: 1.5rem;
}

.about-content ul {
    padding-left: 20px;
}

.about-content li {
    margin-bottom: 0.5rem;
}

/* 响应式设计 */
@media (max-width: 768px) {
    .container {
        width: 95%;
    }
    
    header h1 {
        font-size: 1.6rem;
    }
    
    nav {
        gap: 10px;
    }
    
    nav a {
        font-size: 0.9rem;
        padding: 6px 12px;
    }
    
    .post-inner {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
    }
    
    .post-icon {
        width: auto;
        text-align: left;
    }
    
    .post-actions {
        width: 100%;
        justify-content: flex-end;
    }
    
    .about-content {
        padding: 25px;
    }
    
    main {
        padding: 25px 0;
    }
    
    main h2 {
        font-size: 1.5rem;
    }
}

@media (max-width: 480px) {
    header h1 {
        font-size: 1.4rem;
    }
    
    main h2 {
        font-size: 1.3rem;
    }
    
    .post h3 {
        font-size: 1.1rem;
    }
    
    .post {
        padding: 15px;
    }
    
    .about-content {
        padding: 20px;
    }
}
EOL

# 创建简化的 blog.js
cat <<'EOL' > "${ASSETS_DIR}/blog.js"
document.addEventListener('DOMContentLoaded', function() {
    // 平滑滚动到锚点
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // 检查博客文章加载状态
    const postsGrid = document.getElementById('posts');
    if (postsGrid && postsGrid.children.length === 0) {
        console.log('没有发现文章，可能是源文件夹中没有Markdown文件');
    }
});
EOL

# 创建简化的 index.html
cat <<EOL > "$INDEX_FILE"
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的博客</title>
    <link rel="stylesheet" href="assets/style.css">
    <meta name="description" content="个人博客 - 分享思考与经验">
</head>
<body>
    <header>
        <div class="container">
            <h1><a href="index.html">我的博客</a></h1>
            <nav>
                <a href="index.html">首页</a>
                <a href="about.html">关于</a>
            </nav>
        </div>
    </header>
    
    <main>
        <div class="container">
            <h2>📚 最新文章</h2>
            <div class="posts-grid" id="posts"></div>
            
            <!-- 无文章时显示的提示 -->
            <div class="no-posts" id="no-posts" style="display: none;">
                <h3>暂无文章</h3>
                <p>还没有发布任何文章，请添加Markdown文件到源文件夹。</p>
                <div class="hint">
                    <p>1. 创建 ./md 目录 (如果不存在)</p>
                    <p>2. 添加 .md 文件到该目录</p>
                    <p>3. 重新运行脚本生成博客</p>
                </div>
            </div>
        </div>
    </main>
    
    <footer>
        <div class="container">
            <p>&copy; $(date +%Y) 个人博客. 保留所有权利。</p>
        </div>
    </footer>
    
    <script src="assets/blog.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const posts = [
EOL

# 初始化一个空数组，用于存储文章信息
POSTS_ARRAY=()

# 检查是否有 Markdown 文件
MD_FILES_COUNT=0

# 遍历源文件夹中的 Markdown 文件，并转换为 HTML 格式
if [ -d "$SOURCE_DIR" ]; then
    for md in "$SOURCE_DIR"/*.md; do
        if [ -f "$md" ]; then
            MD_FILES_COUNT=$((MD_FILES_COUNT + 1))
            FILENAME=$(basename "$md" .md)
            last_mod=$(stat -c %Y "$md")
            DATE=$(date -d @"$last_mod" +%Y-%m-%d)
            POST_FILE="${POSTS_DIR}/${DATE}-${FILENAME}.html"

            # 生成文章页面
            cat <<POST_EOF > "$POST_FILE"
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$FILENAME - 我的博客</title>
    <link rel="stylesheet" href="../assets/style.css">
    <meta name="description" content="$FILENAME - 博客文章">
</head>
<body>
    <header>
        <div class="container">
            <h1><a href="../index.html">我的博客</a></h1>
            <nav>
                <a href="../index.html">首页</a>
                <a href="../about.html">关于</a>
            </nav>
        </div>
    </header>
    
    <main>
        <div class="container">
            <article>
                <div class="post-header">
                    <h2>$FILENAME</h2>
                    <div class="post-meta">
                        📅 发布日期：$DATE
                    </div>
                </div>
                <div class="post-content">
POST_EOF

            # 将 Markdown 文档转换为 HTML 内容，并追加到文章页面中
            if command -v pandoc >/dev/null 2>&1; then
                pandoc "$md" -t html >> "$POST_FILE"
            else
                echo "<p>注意：未检测到pandoc命令，无法将Markdown转换为HTML。请安装pandoc后重新运行脚本。</p>" >> "$POST_FILE"
                echo "<pre>$(cat "$md")</pre>" >> "$POST_FILE"
            fi

            # 结束文章页面的 HTML 结构，添加返回首页的链接和页脚
            cat <<POST_END_EOF >> "$POST_FILE"
                </div>
                <a href="../index.html" class="back-link">← 返回首页</a>
            </article>
        </div>
    </main>
    
    <footer>
        <div class="container">
            <p>&copy; $(date +%Y) 个人博客. 保留所有权利。</p>
        </div>
    </footer>
    
    <script src="../assets/blog.js"></script>
</body>
</html>
POST_END_EOF

            echo "已将 $md 转换为文章：$POST_FILE"

            # 将文章信息添加到 POSTS_ARRAY
            POSTS_ARRAY+=("${last_mod}|${FILENAME}|${DATE}")
        fi
    done
else
    echo "警告: 源文件夹 $SOURCE_DIR 不存在"
fi

# 对文章信息按照最后修改日期降序排序
if [ ${#POSTS_ARRAY[@]} -gt 0 ]; then
    IFS=$'\n' sorted_posts=($(printf "%s\n" "${POSTS_ARRAY[@]}" | sort -t"|" -k1 -nr))
    POSTS_COUNT=${#sorted_posts[@]}

    # 将排序后的文章信息写入 index.html 的 posts 数组中
    for i in "${!sorted_posts[@]}"; do
        IFS="|" read -r mod_time title pub_date <<< "${sorted_posts[$i]}"
        
        # 使用正确的JavaScript对象格式
        json_line="                { title: \"${title}\", date: \"${pub_date}\", url: \"posts/${pub_date}-${title}.html\" }"
        
        if [ "$i" -lt $((POSTS_COUNT-1)) ]; then
            echo "${json_line}," >> "$INDEX_FILE"
        else
            echo "${json_line}" >> "$INDEX_FILE"
        fi
    done
fi

# 继续写入 index.html 的剩余部分
cat <<EOL >> "$INDEX_FILE"
            ];

            const postsContainer = document.getElementById('posts');
            const noPostsMessage = document.getElementById('no-posts');
            
            // 检查是否有文章
            if (posts.length === 0) {
                noPostsMessage.style.display = 'block';
            } else {
                // 为每篇文章创建列表项
                posts.forEach((post, index) => {
                    const postElement = document.createElement('div');
                    postElement.classList.add('post');
                    
                    // 简单的图标
                    const icons = ['📄', '📝', '📋', '📖', '📰', '📓'];
                    const randomIcon = icons[Math.floor(Math.random() * icons.length)];
                    
                    const postInner = document.createElement('div');
                    postInner.classList.add('post-inner');
                    
                    postInner.innerHTML = \`
                        <div class="post-icon">\${randomIcon}</div>
                        <div class="post-content">
                            <h3><a href="\${post.url}">\${post.title}</a></h3>
                            <div class="post-meta">
                                📅 发布日期：\${post.date}
                            </div>
                        </div>
                        <div class="post-actions">
                            <a href="\${post.url}" class="read-more">阅读全文 →</a>
                        </div>
                    \`;
                    
                    postElement.appendChild(postInner);
                    postsContainer.appendChild(postElement);
                });
            }
        });
    </script>
</body>
</html>
EOL

# 创建简化的 about.html
cat <<EOL > "$ABOUT_FILE"
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>关于 - 我的博客</title>
    <link rel="stylesheet" href="assets/style.css">
    <meta name="description" content="关于博客作者的介绍">
</head>
<body>
    <header>
        <div class="container">
            <h1><a href="index.html">我的博客</a></h1>
            <nav>
                <a href="index.html">首页</a>
                <a href="about.html">关于</a>
            </nav>
        </div>
    </header>
    
    <main>
        <div class="container">
            <div class="about-content">
                <h2>👋 关于我</h2>
                <p>欢迎来到我的个人博客！这是一个分享我的思考、经验和发现的地方。</p>
                <p>我热衷于学习和分享，通过这个博客平台，希望能够记录下自己的成长历程，也希望能与更多朋友交流。</p>
                
                <h3>📖 关于此博客</h3>
                <p>这个博客使用纯HTML、CSS和JavaScript构建，内容通过Markdown文件生成。设计简洁，专注于内容本身。</p>
                
                <h3>💡 兴趣爱好</h3>
                <ul>
                    <li>技术学习</li>
                    <li>阅读</li>
                    <li>写作</li>
                    <li>探索新事物</li>
                </ul>
                
                <h3>📬 联系方式</h3>
                <p>如果你想与我交流，可以通过以下方式联系我：</p>
                <ul>
                    <li>邮箱：example@email.com</li>
                    <li>GitHub：@username</li>
                </ul>
            </div>
        </div>
    </main>
    
    <footer>
        <div class="container">
            <p>&copy; $(date +%Y) 个人博客. 保留所有权利。</p>
        </div>
    </footer>
    
    <script src="assets/blog.js"></script>
</body>
</html>
EOL

# 输出处理结果和状态
echo "===== 博客更新完成! ====="
if [ $MD_FILES_COUNT -eq 0 ]; then
    echo "警告: 没有找到任何Markdown文件。请添加.md文件到 $SOURCE_DIR 目录。"
else
    echo "成功: 已生成 $MD_FILES_COUNT 篇文章。"
fi
echo "博客地址: $BLOG_DIR/index.html"
echo "=========================="
