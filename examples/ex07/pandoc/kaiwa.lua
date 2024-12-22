function Div(el)
  if el.classes:includes('yomi') then
    -- 'yomi' クラスが含まれている場合、それをLaTeXのyomi環境に変換
    return {
      pandoc.RawBlock('latex', '\\begin{yomi}'),
      el,
      pandoc.RawBlock('latex', '\\end{yomi}')
    }
  end
end
