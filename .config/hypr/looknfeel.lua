-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
-- hl.config({
--   general = {
--     -- No gaps between windows or borders.
--     gaps_in = 0,
--     gaps_out = 0,
--     border_size = 0,
--
--     -- Change to niri-like side-scrolling layout.
--     layout = "scrolling",
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
-- hl.config({
--   decoration = {
--     -- Use round window corners.
--     rounding = 8,
--
--     -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
--     dim_inactive = true,
--     dim_strength = 0.15,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- hl.config({
--   animations = {
--     -- Disable all animations.
--     enabled = false,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })

-- Hyousee island: float+pin, no border. Posisi: file ~/.config/hyousee/position
-- ( ditulis app tiap selesai drag; default top-center ).
do
  local pf = (os.getenv("HOME") or "/home/rakha") .. "/.config/hyousee/position"
  local px, py = nil, nil
  local f = io.open(pf, "r")
  if f then
    local s = f:read("*a")
    f:close()
    px, py = s:match("(%-?%d+)%s+(%-?%d+)")
  end
  if px then
    o.window({ class = "^(hyousee)$", title = "^(hyousee)$" }, { float = true, pin = true, border_size = 0, opacity = "1 1", move = { px, py } })
  else
    o.window({ class = "^(hyousee)$", title = "^(hyousee)$" }, { float = true, pin = true, border_size = 0, opacity = "1 1", move = { "(monitor_w-window_w)/2", "0" } })
  end
end

o.window({ class = "^(hyousee)$", title = "^(hyousee-chat)$" }, { float = true, pin = true, border_size = 0, opacity = "1 1", move = { "(monitor_w-480)/2", "210" } })
