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

end
