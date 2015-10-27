module Jekyll
  module CategoryLinksFilter
    def category_links(categories)
      return '' if categories.empty?

      output = []
      jekyll_archives_installed = Jekyll.const_defined?('Archives', false)
      categories.each do |cat|
        output << (jekyll_archives_installed ? category_link(cat, @context) : cat)
      end
      configs = @context.registers[:site].config
      seperator = configs['categories_seperator'] || ', '

      output.join(seperator)
    end

    def category_link(category, context)
      site = context.registers[:site]
      archive = Archives::Archive.new(site, category, 'category', [])
      url = site.config['baseurl'] + archive.url

      %(<a href="#{url}" title="#{category}">#{category}</a>)
    end

  end
end

Liquid::Template.register_filter(Jekyll::CategoryLinksFilter)
