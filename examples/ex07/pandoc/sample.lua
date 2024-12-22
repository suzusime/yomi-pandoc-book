function Span(el)
  if el.classes:includes('namae') then
    -- 'namae' クラスが含まれている場合、それをLaTeXのnamaeコマンドに変換
    return pandoc.RawInline('latex', '\\namae{' .. el.content[1].text .. '}')
  end
end

function Div(el)
  if el.classes:includes('serifu') then
    -- 'serifu' クラスが含まれている場合、それをLaTeXのserifu環境に変換
    return {
      pandoc.RawBlock('latex', '\\begin{serifu}'),
      el,
      pandoc.RawBlock('latex', '\\end{serifu}')
    }
  end
end
