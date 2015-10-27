module Jekyll
  module CategoryLinksFilter
    def category_links(categories)
      return '' if categories.empty?

      output = []
      jekyll_archives_installed = Jekyll.const_defined?('Archives', false)
      categories.each do |cat|
        cat_data = category_data(cat, @context)
        output << (jekyll_archives_installed ? category_link(cat_data, @context)
                                             : cat_data['name'])
      end
      configs = @context.registers[:site].config
      seperator = configs['categories_seperator'] || ', '

      output.join(seperator)
    end

    def category_link(category_data, context)
      site = context.registers[:site]
      archive = Archives::Archive.new(site, category_data['slug'], 'category', [])
      url = site.config['baseurl'] + archive.url

      %(<a href="#{url}" title="#{category_data['name']}">#{category_data['name']}</a>)
    end

    def category_data(category, context)
      categories_data = context.registers[:site].data['categories']
      slugs = categories_data.map { |e| e['slug'] }

      return {'slug' => category, 'name' => category } unless slugs.include?(category)

      categories_data.select { |e| e['slug'] == category }.first
    end

  end
end

Liquid::Template.register_filter(Jekyll::CategoryLinksFilter)
