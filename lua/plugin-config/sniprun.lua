local status, sniprun = pcall(require, "sniprun")
if not status then
  vim.notify("没有找到 sniprun")
  return
end

sniprun.setup(
  {
    selected_interpreters = { "JS_TS_deno" },
    repl_enable = { "JS_TS_deno" },
    display = { "Terminal" },
  }
)
