-- -- Helper to dynamically find the local typescript/lib path relative to the file buffer
-- local function get_typescript_server_path(root_dir)
--   if not root_dir or root_dir == "" then
--     -- Fallback to finding it starting from the current file buffer if root_dir is missing
--     root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" }) or vim.uv.cwd()
--   end
--
--   local node_modules = vim.fs.find('node_modules', { path = root_dir, upward = true, limit = 1 })[1]
--   if node_modules then
--     local tsdk_path = vim.fs.joinpath(node_modules, 'typescript', 'lib')
--     if vim.uv.fs_stat(tsdk_path) then
--       return tsdk_path
--     end
--   end
--
--   -- IMPORTANT: Fallback to global npm location if project is missing a local typescript folder
--   -- On Linux/macOS: '/usr/local/lib/node_modules/typescript/lib' or check via 'npm root -g'
--   return ""
-- end

return {
  cmd = function(dispatchers, config)
    local cmd = "astro-ls"
    -- Safely deduce root_dir manually if Neovim hasn't attached it yet
    local current_root = config.root_dir or vim.fs.root(0, { "package.json", "tsconfig.json", ".git" }) or vim.uv.cwd()

    if current_root then
      local local_cmd = vim.fs.joinpath(current_root, "node_modules/.bin", cmd)
      if vim.fn.executable(local_cmd) == 1 then
        cmd = local_cmd
      end
    end
    return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
  end,
  filetypes = { "astro" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  init_options = {
    typescript = {
      tsdk = "/usr/local/lib/node_modules/typescript/lib"
    },
  },
}

