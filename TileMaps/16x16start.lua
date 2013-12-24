return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 16,
  height = 16,
  tilewidth = 20,
  tileheight = 20,
  properties = {},
  tilesets = {
    {
      name = "mapTiles",
      firstgid = 1,
      tilewidth = 20,
      tileheight = 20,
      spacing = 0,
      margin = 0,
      image = "../images/TileMap.png",
      imagewidth = 100,
      imageheight = 100,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "land",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      properties = {
        ["mapName"] = "Geldoria"
      },
      encoding = "lua",
      data = {
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
        5, 5, 2, 2, 2, 5, 5, 5, 2, 2, 2, 2, 4, 4, 4, 4,
        5, 2, 2, 2, 2, 2, 5, 2, 2, 2, 2, 2, 2, 4, 4, 4,
        5, 2, 2, 3, 2, 2, 2, 2, 2, 2, 2, 5, 2, 2, 4, 4,
        5, 2, 3, 3, 3, 2, 2, 2, 2, 3, 3, 5, 3, 2, 2, 4,
        5, 2, 2, 3, 2, 2, 2, 2, 3, 3, 5, 5, 3, 3, 2, 2,
        5, 2, 2, 2, 2, 2, 2, 3, 3, 5, 5, 3, 3, 2, 2, 2,
        5, 4, 4, 4, 2, 3, 3, 3, 5, 5, 3, 3, 2, 2, 2, 2,
        5, 4, 4, 2, 3, 3, 3, 3, 5, 3, 3, 3, 2, 2, 2, 2,
        5, 4, 4, 3, 3, 3, 3, 3, 5, 3, 3, 3, 2, 2, 2, 2,
        5, 4, 2, 3, 3, 3, 3, 3, 5, 3, 3, 2, 2, 2, 4, 4,
        5, 2, 2, 2, 2, 2, 3, 3, 5, 3, 3, 2, 2, 2, 4, 4,
        5, 2, 2, 2, 2, 2, 2, 2, 5, 3, 2, 2, 2, 4, 4, 4,
        5, 5, 5, 2, 2, 2, 2, 5, 5, 2, 2, 2, 2, 4, 4, 4,
        5, 5, 5, 5, 5, 2, 2, 5, 5, 5, 3, 3, 4, 4, 4, 4,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
      }
    }
  }
}
