return {
  "sohanemon/flash.yazi",
  lazy = true,
  build = function(plugin)
    require("yazi.plugin").build_plugin(plugin)
  end,
},
