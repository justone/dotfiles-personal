local _2afile_2a = "fnl/conjure-efroot/main.fnl"
local _2amodule_name_2a = "conjure-efroot.main"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("conjure-efroot.aniseed.autoload")).autoload
local a, bridge, config, eval, mapping, nvim, str = autoload("conjure.aniseed.core"), autoload("conjure.bridge"), autoload("conjure.config"), autoload("conjure-efroot.eval"), autoload("conjure.mapping"), autoload("conjure.aniseed.nvim"), autoload("conjure.aniseed.string")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["bridge"] = bridge
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["eval"] = eval
_2amodule_locals_2a["mapping"] = mapping
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["str"] = str
local function on_filetype()
  local function _1_()
    return eval["effective-root-form"]()
  end
  mapping.buf("EvalEffectiveRootForm", "er", _1_, {desc = "Evaluate the effective root form"})
  local function _2_()
    return eval["comment-effective-root-form"]()
  end
  return mapping.buf("EvalCommentEffectiveRootForm", "ecr", _2_, {desc = "Evaluate the effective root form into a comment"})
end
_2amodule_2a["on-filetype"] = on_filetype
local function init()
  config["assoc-in"]({"mapping", "eval_root_form"}, "eR")
  config["assoc-in"]({"mapping", "eval_comment_root_form"}, "ecR")
  return nvim.ex.autocmd("FileType", str.join(",", config.filetypes()), bridge["viml->lua"]("conjure-efroot.main", "on-filetype", {}))
end
_2amodule_2a["init"] = init
return _2amodule_2a