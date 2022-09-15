
local opts = {}

-- 查看目录等信息
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
