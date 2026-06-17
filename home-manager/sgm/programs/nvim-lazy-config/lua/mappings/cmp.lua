-- lua/mappings/cmp.lua
-- ============================================================
-- ГОРЯЧИЕ КЛАВИШИ ДЛЯ CMP (дополнительные, вне меню)
-- ============================================================
-- Основные хоткеи управления меню (Tab, Enter, Ctrl+Space) определены
-- внутри cmp.setup.mapping в plugins/cmp.lua, т.к. это cmp.mapping.
-- Здесь — дополнительные хоткеи для работы со сниппетами.

local map = require("core.utils").map

-- === Сниппеты: выбор варианта ===
-- <C-k> — следующий вариант сниппета (если есть выбор)
map({ "i", "s" }, "<C-k>", function()
  if require("luasnip").choice_active() then
    require("luasnip").change_choice(1)
  end
end, { desc = "Next snippet choice" })

-- <C-j> — предыдущий вариант сниппета
map({ "i", "s" }, "<C-j>", function()
  if require("luasnip").choice_active() then
    require("luasnip").change_choice(-1)
  end
end, { desc = "Previous snippet choice" })

-- === Сниппеты: принудительное раскрытие ===
-- <C-l> — раскрыть сниппет вручную (если авто-раскрытие не сработало)
map("i", "<C-l>", function()
  if require("luasnip").expandable() then
    require("luasnip").expand()
  end
end, { desc = "Expand snippet" })

-- === Сниппеты: выход из сниппета ===
-- <C-c> — выйти из сниппета, не завершая его
map({ "i", "s" }, "<C-c>", function()
  if require("luasnip").in_snippet() then
    require("luasnip").unlink_current()
  end
end, { desc = "Exit snippet" })
