head -1 */*.txt | perl -ne 'chomp if m/^==>/; print if (length $_ > 2)' | ruby -ne '$_.chomp!; all, file, title = %r{^.*==> (\w+/\w+\.\w+) <==(.*)$}.match($_).to_a; title.gsub!(%r{.*Project Gutenberg(?:'"'"'s)?\s*E(?:text|book)\s*(?:,|of)?\s*}i,"") if title; puts (file ? ("%-60s %s" % [title, file]) : "!!!!!!!!!"+$_)' > titles.txt
