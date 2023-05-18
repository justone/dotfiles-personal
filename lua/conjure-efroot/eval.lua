local _2afile_2a = "fnl/conjure-efroot/eval.fnl"
local _2amodule_name_2a = "conjure-efroot.eval"
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
local buffer, client, config, eval, extract, nvim = autoload("conjure.buffer"), autoload("conjure.client"), autoload("conjure.config"), autoload("conjure.eval"), autoload("conjure-efroot.extract"), autoload("conjure.aniseed.nvim")
do end (_2amodule_locals_2a)["buffer"] = buffer
_2amodule_locals_2a["client"] = client
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["eval"] = eval
_2amodule_locals_2a["extract"] = extract
_2amodule_locals_2a["nvim"] = nvim
local function effective_root_form()
  local form = extract["effective-root-form"]()
  if form then
    local _let_1_ = form
    local content = _let_1_["content"]
    local range = _let_1_["range"]
    return eval["eval-str"]({code = content, range = range, origin = "effective-root-form"})
  else
    return nil
  end
end
_2amodule_2a["effective-root-form"] = effective_root_form
local function insert_result_comment(tag, input)
  local buf = nvim.win_get_buf(0)
  local comment_prefix = (config["get-in"]({"eval", "comment_prefix"}) or client.get("comment-prefix"))
  if input then
    local _let_3_ = input
    local content = _let_3_["content"]
    local range = _let_3_["range"]
    local function _4_(result)
      return buffer["append-prefixed-line"](buf, range["end"], comment_prefix, result)
    end
    eval["eval-str"]({code = content, range = range, origin = ("comment-" .. tag), ["suppress-hud?"] = true, ["on-result"] = _4_})
    return input
  else
    return nil
  end
end
_2amodule_locals_2a["insert-result-comment"] = insert_result_comment
local function comment_effective_root_form()
  return insert_result_comment("effective-root-form", extract["effective-root-form"]())
end
_2amodule_2a["comment-effective-root-form"] = comment_effective_root_form
return _2amodule_2a