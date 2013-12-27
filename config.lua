-- config.lua

application =
{
	content =
	{
		width = 320,
		height = 480,
		scale = "zoomstretch",
		--scale = "zoomstretch", -- zoom to fill screen, possibly cropping edges
		fps = 20
	},
}


--[[

PIXEL PERFECT CONFIG

local w, h = display.pixelWidth, display.pixelHeight
if w >= 480 then
    w = w * 0.5
    h = h * 0.5
end
if w >= 480 then
    w = w * 0.5
    h = h * 0.5
end
application = {
    content = {
        width = w, height = h,
        scale = 'letterbox',
        imageSuffix = {['@2x'] = 1.2, ['@4x'] = 2.5},
        fps = 60
                }}

]]