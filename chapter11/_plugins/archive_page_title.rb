require_relative 'category_links'

module Jekyll
  class ArchivePageTitleTag < Liquid::Tag
    include CategoryLinksFilter

    ARCHIVE_PAGE_TYPES = %w(category tag year month day)

    def render(context)
      # 检查 jekyll-archives 插件是否已经安装
      unless Jekyll.const_defined?('Archives', false)
        return "" # 沉默是金
      end

      page = context.environments.first['page']

      # 检查当前页面是否为五个归档页面之一
      page_type = page['type']
      unless ARCHIVE_PAGE_TYPES.include? page_type
        return "" # 沉默是金
      end

      case page_type
      when 'category'
        "“#{category_data(page['title'], context)['name']}”分类的归档"
      when 'tag'
        "“#{page['title']}”标签的归档"
      when 'year'
        page['date'].strftime('%Y年') << '归档'
      when 'month'
        page['date'].strftime('%Y年%-m月') << '归档'
      when 'day'
        page['date'].strftime('%Y年%-m月%-d日') << '归档'
      end

    end
  end
end

Liquid::Template.register_tag('archive_page_title', Jekyll::ArchivePageTitleTag)
