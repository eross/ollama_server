-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = "auto"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- BEGIN OMARCHY QEMU PROFILE
-- QEMU publishes the live window's size and host refresh rate through Virtio
-- GPU EDID. Quattro's preceding automatic monitor rule stays authoritative;
-- keep the guest cursor visible because SDL displays the guest scanout
-- directly (hiding it was a VNC-host assumption).
local function omarchy_kernel_option_enabled(expected_option)
  if type(io) ~= "table" or type(io.open) ~= "function" then
    return false
  end

  local opened, cmdline_file = pcall(io.open, "/proc/cmdline", "r")
  if not opened or not cmdline_file then
    return false
  end

  local read_ok, cmdline = pcall(cmdline_file.read, cmdline_file, "*a")
  pcall(cmdline_file.close, cmdline_file)
  if not read_ok or type(cmdline) ~= "string" then
    return false
  end

  for option in cmdline:gmatch("%S+") do
    if option == expected_option then
      return true
    end
  end
  return false
end

if omarchy_kernel_option_enabled("omarchy.qemu=1") then
  hl.config({ cursor = { invisible = false } })
  o.exec_on_start("/usr/local/bin/omarchy-native-display-sync")
end

-- On CPU rendering (llvmpipe) every animation frame is CPU time the desktop
-- feels. Start with animations off; looknfeel.lua loads after this file, so
-- an explicit choice there still wins.
if omarchy_kernel_option_enabled("tryomarchy.render=cpu") then
  hl.config({ animations = { enabled = false } })
end
-- END OMARCHY QEMU PROFILE
