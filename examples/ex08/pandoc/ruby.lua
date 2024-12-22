-- Markdown埋め込みHTMLのルビをLaTeXのルビに変換するフィルター
-- 例: <ruby>漢字<rt>かんじ</rt></ruby> -> \ruby{漢字}{かんじ}

function Inlines (inlines)
  -- 途中で配列の要素数が変わっても大丈夫なように配列の後ろから処理する
  --   i: ルビの終わりのインデックスを探すためのカウンタ
  --   j: ルビの始まりのインデックスを探すためのカウンタ
  local i = #inlines
  while i > 0 do
    if inlines[i].t == 'RawInline' and string.match(inlines[i].text, "</ruby>") then
      local j = i - 1
      while j > 0 do
        if inlines[j].t == 'RawInline' and string.match(inlines[j].text, "<ruby>") then
          -- ルビの始まりと終わりが見つかった
          local ruby_start_index = j
          local ruby_end_index = i

          -- 満たされるべき条件を確認する
          local ok = (
            ruby_end_index - ruby_start_index == 5 and
            inlines[ruby_start_index + 1].t == 'Str' and
            inlines[ruby_start_index + 2].text == "<rt>" and
            inlines[ruby_start_index + 3].t == 'Str' and
            inlines[ruby_start_index + 4].text == "</rt>"
          )

          -- 条件にあっていれば、これらのタグをLaTeXのルビに置き換える
          if ok then
            local ruby_text = inlines[ruby_start_index + 1].text
            local rt_text = inlines[ruby_start_index + 3].text

            -- ルビの始まりから終わりまでの要素を一旦削除する
            for k = ruby_end_index, ruby_start_index, -1  do
              inlines:remove(k)
            end

            -- LaTeXのルビを挿入する
            local ruby_element = pandoc.RawInline('latex', "\\ruby{" .. ruby_text .. "}{" .. rt_text .. "}")
            inlines:insert(ruby_start_index, ruby_element)
          end

          -- このルビは処理済みなので、次のルビを探す
          i = ruby_start_index
          break
        end -- if inlines[j].t == 'RawInline' の終わり
        j = j - 1
      end -- while j > 0 の終わり
    end -- if inlines[i].t == 'RawInline' の終わり
    i = i - 1
  end -- while i > 0 の終わり

  -- 修正されたinlinesを返す
  return inlines
end
