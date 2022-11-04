# Typora 导出设置

```
设置 -> 导出 -> pdf
A4
自动使用当前主题（github）
按一级标题分页
${title} @ ${author}
No. ${pageNo} / ${totalPages}
```

## add cover in pdf

在Typora导出pdf时，额外补充html内容。
```html
<meta name="title" content="${title}">
<div id='_export_cover' style="height:100vh;">
    <div id='_export_title' style="margin-top: 25%;text-align: center;font-size: 3rem;">
    </div>
    <div id='_export_author' style="margin-top: 65%;text-align: center;font-size: 1rem;"></div>
</div>
<script>
    var $cover = document.querySelector("#_export_cover");
    var title = document.querySelector("meta[name='title']").getAttribute("content");
    if (!title || title === "${title}") {
        // no title
        $cover.remove();
    } else {
        document.body.insertBefore($cover, document.body.childNodes[0])
        $cover.querySelector("#_export_title").textContent = title;
        $cover.querySelector("#_export_author").textContent = "author: wdpm";
    }
</script>
```

## add toc
在yml元信息文件中追加：
```markdown
# Table of Contents

[TOC]

<div style="page-break-after: always;"></div>
```
> 注意这个方法有个渲染BUG：在导出pdf后，第一级标题 Table of Contents 会被重复生成为段落文本 `Table of Contents`，出现在目录中。

## reference
- [Typora Export](https://support.typora.io/Export/#header--footer)