module ApplicationHelper

    def message_escape(message)
        simple_format(text_url_to_link(h(message)).html_safe, {}, :sanitize => false)
    end
    
    def text_url_to_link(text)
        URI.extract(text, ['http', 'https']).uniq.each do |url|
            sub_text = link_to url, url, target: '_blank'
            text.gsub!(url, sub_text)
        end
        text
    end

    def markdown(content)
        options = {
        autolink: true,
        space_after_headers: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        tables: true,
        hard_wrap: true,
        xhtml: true,
        lax_html_blocks: true,
        strikethrough: true
        }

        renderer = Redcarpet::Render::HTML.new
        markdown = Redcarpet::Markdown.new(renderer, options)
        markdown.render(content)
    end
    
end
