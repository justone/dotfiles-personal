local _2afile_2a = "fnl/conjure-macroexpand/main.fnl"
local _2amodule_name_2a = "conjure-macroexpand.main"
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
local a, bridge, client, eval, extract, log, mapping, nvim, str = require("conjure-macroexpand.aniseed.core"), require("conjure.bridge"), require("conjure.client"), require("conjure.eval"), require("conjure.extract"), require("conjure.log"), require("conjure.mapping"), require("conjure-macroexpand.aniseed.nvim"), require("conjure-macroexpand.aniseed.string")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["bridge"] = bridge
_2amodule_locals_2a["client"] = client
_2amodule_locals_2a["eval"] = eval
_2amodule_locals_2a["extract"] = extract
_2amodule_locals_2a["log"] = log
_2amodule_locals_2a["mapping"] = mapping
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["str"] = str
local function current_form()
  local form = extract.form({})
  if form then
    local _let_1_ = form
    local content = _let_1_["content"]
    return content
  else
    return nil
  end
end
_2amodule_locals_2a["current-form"] = current_form
local function clj_client(f, args)
  return client["with-filetype"]("clojure", f, args)
end
_2amodule_locals_2a["clj-client"] = clj_client
local function output_expanded(orig)
  local function _3_(r)
    return log.append(a.concat({("; " .. orig)}, str.split(r, "\n")), {["break?"] = true})
  end
  return _3_
end
_2amodule_locals_2a["output-expanded"] = output_expanded
local function clj_macroexpand(expand_cmd)
  local form = current_form()
  local me_form = ("(" .. (expand_cmd or "clojure.walk/macroexpand-all") .. " '" .. form .. ")")
  return clj_client(eval["eval-str"], {origin = "conjure-macroexpand", code = me_form, ["passive?"] = true, ["on-result"] = output_expanded(me_form)})
end
_2amodule_2a["clj-macroexpand"] = clj_macroexpand
local function add_buf_mappings()
  local function _4_()
    return clj_macroexpand()
  end
  mapping.buf("CljMacroexpand", "cm", _4_, {desc = "Call macroexpand-all on the symbol under the cursor"})
  local function _5_()
    return clj_macroexpand("clojure.core/macroexpand")
  end
  mapping.buf("CljMacroexpand0", "c0", _5_, {desc = "Call macroexpand on the symbol under the cursor"})
  local function _6_()
    return clj_macroexpand("clojure.core/macroexpand-1")
  end
  return mapping.buf("CljMacroexpand1", "c1", _6_, {desc = "Call macroexpand-1 on the symbol under the cursor"})
end
_2amodule_2a["add-buf-mappings"] = add_buf_mappings
local function init()
  if (not nvim.g.conjure_macroexpand_disable_mappings or (0 == nvim.g.conjure_macroexpand_disable_mappings)) then
    return nvim.ex.autocmd("FileType", "clojure", bridge["viml->lua"]("conjure-macroexpand.main", "add-buf-mappings"))
  else
    return nil
  end
end
_2amodule_2a["init"] = init
return _2amodule_2a