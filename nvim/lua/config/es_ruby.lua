-- define custom language server
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

configs.es_ruby = {
  default_config = {
    cmd = { 'nc', 'localhost', '8341' },
    filetypes = { 'ruby', },
    root_dir = util.root_pattern('Gemfile', '.git'),
  },
  docs = {
    description = [[
      Language server for Ruby, backed by Elastic search.
    ]],
    default_config = {
      root_dir = [[root_pattern('Gemfile', '.git')]],
    },
  },
}

-- manual setup:
-- docker pull blinknlights/elastic_ruby_server
-- docker volume create elastic_ruby_server-0.2.0 (this could be anything but for now match the vscode extension)
--[[
  docker run \
    -d \
    --rm \
    --name elastic-ruby-server \
    --ulimit memlock=-1:-1 \
    -v elastic_ruby_server-0.2.0:/usr/share/elasticsearch/data \
    -p 8341:8341 \
    -e SERVER_PORT=8341 \
    -e LOG_LEVEL=DEBUG \
    -e HOST_PROJECT_ROOTS="/Users/kevinhughes/clio" \
    --mount "type=bind,source=/Users/kevinhughes/clio,target=/projects/clio,readonly" \
    blinknlights/elastic_ruby_server
]]
