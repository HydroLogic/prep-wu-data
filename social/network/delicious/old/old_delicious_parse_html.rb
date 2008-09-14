
  # def find_pagewide_socialite hdoc
  #   # get user
  #   nil
  # end
  # def find_pagewide_link hdoc
  #   urldiv = hdoc/'div.UrlDetail#pagetitleContent'
  #   return nil if urldiv.blank?
  #   link_url             = (urldiv.at 'p#url/a').attributes['href']
  #   delicious_id         = (hdoc.at 'head/link[@title="RSS feed"]').attributes['href'].split(/\//).last
  #   num_delicious_savers = (urldiv.at 'p#savedBy//span').inner_html
  #   canonical_title      = (urldiv.at 'h2/a').inner_html
  #   DeliciousLink.find_or_create(
  #     { :delicious_id => delicious_id },
  #     { :link_url     => link_url,
  #       :title        => canonical_title,
  #       :num_delicious_savers => num_delicious_savers })
  # end
  #
  # #
  # # Parse the html file into an intermediate structure
  # def parse_links hdoc
  #   raw_taggings = extract_links(hdoc)
  #   raw_taggings['//ul.bookmarks/li']
  # end
  #
  # def raw_bookmark(raw) raw['div.bookmark'][0]  end
  # def delicious_link_id_from_raw raw
  #   raw[:delicious_id][0].gsub(/^(?:[a-z]+-)?([0-9a-f]{32})(?:-.{0,2})$/, '\1')
  # end
  # def link_url_from_raw raw
  #   raw_bookmark(raw)['.data/h4/a.taggedlink'].first[:link_url].first
  # end
  # def date_tagged_from_raw raw, old_date_tagged
  #   raw_bookmark(raw)['.dateGroup/span'] ? raw_bookmark(raw)['.dateGroup/span'][0][:date_tagged][0] : old_date_tagged
  # end
  # def socialite_name_from_raw raw
  #   if raw_bookmark(raw)[:user_name] then return raw_bookmark(raw)[:user_name] end
  #   # ok fine do it the hard way
  #   begin
  #     socialite_name = raw_bookmark(raw)["div.tagdisplay/ul.tag-chain/li.first/a"][0][:linker_tag_url][0]
  #     if (socialite_name =~ %r{^/([^/]+)}) then $1 end
  #   rescue
  #     warn "Don't understand username in #{raw_bookmark(raw).inspect}"
  #     return "!!bogus!!"
  #   end
  # end
  # # (:num_delicious_savers, :tag_strs, :description, :text)
  # def method_missing meth, *args
  #   if meth.to_s =~ /^(.*)_from_raw$/
  #     raw = raw_bookmark args[0]
  #     raw[$1.to_sym]
  #   else
  #     super
  #   end
  # end
  #
  # # pivot parse_links' intermediate structure into yaml raw_taggings
  # def raw_taggings_to_db raw_taggings, pagewide_link=nil, pagewide_socialite=nil
  #   date_tagged = ''
  #   raw_taggings.map do |raw|
  #     if pagewide_link then link = pagewide_link
  #     else
  #       link      = DeliciousLink.find_or_create(
  #         { :delicious_id => delicious_link_id_from_raw(raw) },
  #         { :link_url     => link_url_from_raw(raw),
  #           :num_delicious_savers => num_delicious_savers_from_raw(raw) })
  #       link.title = text_from_raw(raw) if link.title.blank?
  #       link.save
  #       puts link.attributes.to_yaml
  #     end
  #     if pagewide_socialite then socialite = pagewide_socialite
  #     else
  #       socialite_name = socialite_name_from_raw(raw)
  #       socialite = Socialite.find_or_create(
  #         { :name         => socialite_name},
  #         { :uniqname     => "http://delicious.com/#{socialite_name}"})
  #     end
  #     # Socialite linked to link
  #     date_tagged = date_tagged_from_raw(raw, date_tagged)
  #     linking = SocialitesLink.find_or_create({
  #         :delicious_link_id => link.id,
  #         :socialite_id => socialite.id  })
  #     linking.attributes = {
  #       :date_tagged  => date_tagged,
  #       :text         => text_from_raw(raw),
  #       :description  => description_from_raw(raw)
  #     }
  #     linking.save
  #     # Socialite, Tag => Link
  #     tag_strs    = tag_strs_from_raw(raw)
  #     tag_strs.each do |tag_str|
  #       tag     = Tag.find_or_create({ :name => tag_str })
  #       tagging = Tagging.find_or_create({ :tag_id => tag.id, :delicious_link_id => link.id, :socialite_id => socialite.id})
  #     end if tag_strs
  #     # puts "%-18s %-80s %s" % [socialite.name, link.link_url, link.taggings(:socialite_id => socialite.id).map{|t| t.tag.name }.join(", ") ]
  #   end
  # end
