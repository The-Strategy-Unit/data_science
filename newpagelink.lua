-- filter to open links in new tabs, only if the links are external
-- partially thanks
--   https://github.com/quarto-dev/quarto-cli/discussions/3169#discussioncomment-4058805
--   https://groups.google.com/g/pandoc-discuss/c/F5uolkngyQI/m/Wh4_kGkJCQAJ

function Link(link)
  -- if links are internal then they should be relative
  -- if links are external then they should start with http(s)
  if not string.match(link.target, "^http") then
    link.attributes.target = "_blank"
  end
  return link
end
