local wezterm = require 'wezterm'

return {
    keys = {},
    enable_tab_bar = false,
    default_prog = { '/usr/bin/zsh', '-l' },
    window_padding = {
        left = 1,
        right = 1,
        top = 1,
        bottom = 1,
    },
    window_frame = {
        border_left_width = '0.25cell',
        border_right_width = '0.25cell',
        border_bottom_height = '0.125cell',
        -- border_top_height = '0cell',
        border_left_color = '#333',
        border_right_color = '#333',
        border_bottom_color = '#333',
        -- border_top_color = '#333',
    },
  }

