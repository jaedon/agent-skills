function Str(el)
  local text = el.text
  local has_korean = false

  for _, codepoint in utf8.codes(text) do
    if (codepoint >= 0xAC00 and codepoint <= 0xD7A3)
      or (codepoint >= 0x1100 and codepoint <= 0x11FF)
      or (codepoint >= 0x3130 and codepoint <= 0x318F) then
      has_korean = true
      break
    end
  end

  local result = {}
  local start = 1
  local has_arrow = false

  while true do
    local first, last = text:find('↔', start, true)
    if not first then
      if start <= #text then
        table.insert(result, pandoc.Str(text:sub(start)))
      end
      break
    end

    has_arrow = true
    if first > start then
      table.insert(result, pandoc.Str(text:sub(start, first - 1)))
    end
    -- Keep Pandoc's text-style variation selector from rendering as a missing glyph.
    table.insert(result, pandoc.RawInline('html', '↔'))
    start = last + 1
  end

  if has_korean then
    if not has_arrow then
      result = {el}
    end
    return pandoc.Span(result, pandoc.Attr('', {'korean-word'}))
  end

  if has_arrow then
    return result
  end
end
