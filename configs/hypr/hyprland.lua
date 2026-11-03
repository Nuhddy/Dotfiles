local nix = require 'nix'

-- Outputs
hl.monitor {
  output = nix['display']['name'],
  mode = 'highrr',
  position = 'auto',
  scale = nix['display']['scale'],
  vrr = nix['display']['vrr'],
}

-- Autostart
hl.on('hyprland.start', function()
  hl.exec_cmd 'noctalia'
  hl.exec_cmd 'jamesdsp -t'
  hl.exec_cmd 'bitwarden-desktop'
  hl.exec_cmd 'nextcloud'
end)

-- Input
local kb_options = 'caps:swapescape,grp:ctrl_space_toggle'
hl.config {
  input = {
    kb_layout = 'us,dk',
    kb_options = kb_options,
    repeat_delay = 300,
    repeat_rate = 50,
    accel_profile = 'flat',
    follow_mouse = 2,
    touchpad = {
      natural_scroll = true,
    },
  },
  cursor = { no_warps = true },
}

-- Animations
hl.curve(
  'easeOutQuint',
  { type = 'bezier', points = { { 0.23, 1 }, { 0.32, 1 } } }
)

local speed = 3
local bezier = 'easeOutQuint'
hl.animation {
  leaf = 'global',
  enabled = true,
  speed = speed,
  bezier = bezier,
}
hl.animation {
  leaf = 'workspaces',
  style = 'slidevert',
  enabled = true,
  speed = speed,
  bezier = bezier,
}

-- Appearance
local gaps = 4
hl.config {
  general = {
    border_size = 1,
    gaps_in = gaps,
    gaps_out = gaps * 2,
    col = {
      active_border = '#89b4fa',
      inactive_border = '#585b70',
    },
    allow_tearing = true,
  },
  decoration = {
    blur = { enabled = false },
    rounding = 14,
  },
}

-- Layouts
hl.config {
  general = { layout = 'scrolling' },
  master = {
    mfact = 0.6,
    orientation = 'right',
  },
}

-- Misc
hl.config {
  ecosystem = { no_donation_nag = true },
  misc = {
    disable_hyprland_logo = true,
    force_default_wallpaper = 0,
    disable_splash_rendering = true,
  },
}

-- Rules
hl.workspace_rule { workspace = '1', persistent = true }
hl.workspace_rule { workspace = '2', persistent = true }
hl.workspace_rule { workspace = '3', persistent = true }
hl.workspace_rule { workspace = '4', persistent = true, layout = 'monocle' }
hl.workspace_rule { workspace = '5', persistent = true, layout = 'monocle' }

hl.window_rule {
  match = { class = 'steam_app_252950' },
  immediate = true,
}
hl.window_rule {
  match = { class = 'vesktop' },
  workspace = '4',
}
hl.window_rule {
  match = { class = 'tidal-hifi' },
  workspace = '5',
}
hl.window_rule {
  match = { class = 'steam', title = 'Friends List*' },
  float = true,
}

-- Bindings
---@param bind_table table
---@return function
local bind_per_layout = function(bind_table)
  return function()
    local workspace = hl.get_active_workspace()

    if not workspace then return end

    local layout = workspace.tiled_layout

    if bind_table[layout] then
      hl.dispatch(bind_table[layout])
    elseif bind_table['default'] then
      hl.dispatch(bind_table['default'])
    end
  end
end

local term = 'kitty -1'
local noct = 'noctalia msg '

hl.bind('SUPER + Return', hl.dsp.exec_cmd(term))
hl.bind('SUPER + Space', hl.dsp.exec_cmd(noct .. 'panel-toggle launcher'))
hl.bind('SUPER + E', hl.dsp.exec_cmd 'nautilus')
hl.bind('CTRL + SHIFT + Escape', hl.dsp.exec_cmd(term .. ' -e btop'))

hl.bind('SUPER + SHIFT + Q', hl.dsp.window.close())
hl.bind('SUPER + S', hl.dsp.window.float { action = 'toggle' })
hl.bind('SUPER + F', hl.dsp.window.fullscreen { action = 'toggle' })

-- hl.bind('ALT + Tab', hl.dsp.focus { last = true })
hl.bind(
  'ALT + Tab',
  hl.dsp.exec_cmd(noct .. 'window-switcher'),
  { submap_universal = true }
)
hl.bind(
  'SUPER + H',
  hl.dsp.focus { direction = 'left' },
  { submap_universal = true }
)
hl.bind(
  'SUPER + L',
  hl.dsp.focus { direction = 'right' },
  { submap_universal = true }
)
hl.bind(
  'SUPER + J',
  bind_per_layout {
    monocle = hl.dsp.layout 'cycleprev',
    default = hl.dsp.focus { direction = 'down' },
  },
  { submap_universal = true }
)
hl.bind(
  'SUPER + K',
  bind_per_layout {
    monocle = hl.dsp.layout 'cyclenext',
    default = hl.dsp.focus { direction = 'up' },
  },
  { submap_universal = true }
)

hl.bind('SUPER + SHIFT + H', hl.dsp.window.swap { direction = 'left' })
hl.bind('SUPER + SHIFT + L', hl.dsp.window.swap { direction = 'right' })
hl.bind(
  'SUPER + SHIFT + J',
  bind_per_layout {
    monocle = hl.dsp.window.swap { prev = true },
    default = hl.dsp.window.swap { direction = 'down' },
  }
)
hl.bind(
  'SUPER + SHIFT + K',
  bind_per_layout {
    monocle = hl.dsp.window.swap { next = true },
    default = hl.dsp.window.swap { direction = 'up' },
  }
)

for i = 1, 5 do
  hl.bind(
    'SUPER + ' .. i,
    hl.dsp.focus { workspace = i },
    { submap_universal = true }
  )
  hl.bind(
    'SUPER + SHIFT + ' .. i,
    hl.dsp.window.move { workspace = i },
    { submap_universal = true }
  )
end

hl.bind('SUPER + tab', function()
  local layouts = { 'scrolling', 'master', 'monocle' }
  local workspace = hl.get_active_workspace()
  local next_layout = layouts[2]

  if not workspace then return end

  for i = 1, #layouts do
    if layouts[i] == workspace.tiled_layout then
      local next_layout_idx = (i % #layouts) + 1
      next_layout = layouts[next_layout_idx]
      break
    end
  end

  hl.workspace_rule {
    workspace = tostring(workspace.name),
    layout = next_layout,
  }
end)

hl.bind('SUPER + BracketLeft', function()
  hl.dispatch(
    hl.dsp.exec_cmd(
      noct
        .. 'notification-show \'{"app_name": "", "timeout_ms": 1500, "icon": "device-speaker", "summary": "Equalizer", "body": "EQ preset changed to Flat"}\''
    )
  )
  hl.dispatch(hl.dsp.exec_cmd 'jamesdsp --load-preset Flat')
end, { locked = true, submap_universal = true })
hl.bind('SUPER + BracketRight', function()
  hl.dispatch(
    hl.dsp.exec_cmd(
      noct
        .. 'notification-show \'{"app_name": "", "timeout_ms": 1500, "icon": "headphones", "summary": "Equalizer", "body": "Preset changed to Headphones"}\''
    )
  )
  hl.dispatch(hl.dsp.exec_cmd 'jamesdsp --load-preset Headphones')
end, { locked = true, submap_universal = true })

hl.bind(
  'SUPER + End',
  hl.dsp.exec_cmd(noct .. 'media playPause'),
  { locked = true, submap_universal = true }
)
hl.bind(
  'SUPER + Delete',
  hl.dsp.exec_cmd(noct .. 'media previous'),
  { locked = true, submap_universal = true }
)
hl.bind(
  'SUPER + Next',
  hl.dsp.exec_cmd(noct .. 'media next'),
  { locked = true, submap_universal = true }
)

hl.bind('ALT + End', hl.dsp.exec_cmd(noct .. 'nightlight-toggle'))

hl.bind('CTRL + ALT + Delete', hl.dsp.exec_cmd(noct .. 'panel-toggle session'))

hl.bind('SUPER + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind('SUPER + mouse:273', hl.dsp.window.resize(), { mouse = true })

-- CoolerControl modes
local cc_mode = function(name)
  return hl.dsp.exec_cmd(([[
    T="%s"
    U=$(curl -s -H "Authorization: Bearer $T" http://localhost:11987/modes \
      | jq -r '.modes[] | select(.name=="%s") | .uid')
    [ -n "$U" ] && curl -s -H "Authorization: Bearer $T" -X POST http://localhost:11987/modes-active/$U
  ]]):format(nix['cc_token'], name))
end

hl.bind('SUPER + SHIFT + BracketLeft', cc_mode 'Silent')
hl.bind('SUPER + SHIFT + BracketRight', cc_mode 'Main')

-- Per-class submap with limited keybinds
hl.define_submap(
  'excl',
  function() hl.bind('SUPER + F12', hl.dsp.submap 'reset') end
)

local activate_excl = function()
  hl.config { input = { kb_options = '' } }
  hl.dispatch(hl.dsp.submap 'excl')
end

local deactivate_excl = function()
  hl.config { input = { kb_options = kb_options } }
  hl.dispatch(hl.dsp.submap 'reset')
end

local is_excl_submap_class = {}
for _, x in ipairs {
  'com.mojang.minecraft',
} do
  is_excl_submap_class[x] = true
end

hl.on('window.active', function(w)
  if w ~= nil and is_excl_submap_class[w.class] then
    if hl.get_current_submap() ~= 'excl' then activate_excl() end
  elseif hl.get_current_submap() == 'excl' then
    deactivate_excl()
  end
end)
