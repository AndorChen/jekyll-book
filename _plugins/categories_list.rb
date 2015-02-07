require_relative 'category_links'

module Jekyll
  class CategoriesListTag < Liquid::Tag
    include CategoryLinksFilter

    def render(context)
      site = context.registers[:site]
      show_count = site.config['show_count_in_categories_list'] || true
      jekyll_archives_installed = Jekyll.const_defined?('Archives', false)

      output = '<ul>'
      site.categories.each do |cat, posts|
        cat_data = category_data(cat, context)
        output << '<li>'

        if jekyll_archives_installed
          output << category_link(cat_data, context)
        else
          output << cat_data['name']
        end

        if show_count
          output << " (#{posts.size})"
        end

        output << '</li>'
      end

      output << '</ul>'
    end

  end
end

Liquid::Template.register_tag('categories_list', Jekyll::CategoriesListTag)
