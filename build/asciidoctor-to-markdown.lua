local flatten_div_classes = {
  content = true,
  details = true,
  imageblock = true,
  listingblock = true,
  literalblock = true,
  olist = true,
  paragraph = true,
  preamble = true,
  sectionbody = true,
  sect1 = true,
  sect2 = true,
  sect3 = true,
  sect4 = true,
  sect5 = true,
  ulist = true,
}

local flatten_div_ids = {
  content = true,
  header = true,
  preamble = true,
  toc = true,
  toctitle = true,
}

local flatten_span_classes = {
  author = true,
  image = true,
}

local flatten_span_ids = {
  revnumber = true,
}

function Div(el)
  if flatten_div_ids[el.identifier] then
    return el.content
  end

  for _, class in ipairs(el.classes) do
    if flatten_div_classes[class] then
      return el.content
    end
  end
end

function Span(el)
  if flatten_span_ids[el.identifier] then
    return el.content
  end

  for _, class in ipairs(el.classes) do
    if flatten_span_classes[class] then
      return el.content
    end
  end
end
