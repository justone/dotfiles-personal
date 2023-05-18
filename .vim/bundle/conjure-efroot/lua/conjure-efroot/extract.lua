local _2afile_2a = "fnl/conjure-efroot/extract.fnl"
local _2amodule_name_2a = "conjure-efroot.extract"
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
local a, config, mapping, nvim, searchpair, str = autoload("conjure.aniseed.core"), autoload("conjure.config"), autoload("conjure.mapping"), autoload("conjure.aniseed.nvim"), autoload("conjure.extract.searchpair"), autoload("conjure.aniseed.string")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["mapping"] = mapping
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["searchpair"] = searchpair
_2amodule_locals_2a["str"] = str
local function nil_pos_3f(pos)
  return (not pos or (0 == unpack(pos)))
end
_2amodule_locals_2a["nil-pos?"] = nil_pos_3f
local function read_range(_1_, _3_)
  local _arg_2_ = _1_
  local srow = _arg_2_[1]
  local scol = _arg_2_[2]
  local _arg_4_ = _3_
  local erow = _arg_4_[1]
  local ecol = _arg_4_[2]
  local lines = nvim.buf_get_lines(0, (srow - 1), erow, false)
  local function _5_(s)
    return string.sub(s, 0, ecol)
  end
  local function _6_(s)
    return string.sub(s, scol)
  end
  return str.join("\n", a.update(a.update(lines, #lines, _5_), 1, _6_))
end
_2amodule_locals_2a["read-range"] = read_range
local function skip_match_3f()
  local _let_7_ = nvim.win_get_cursor(0)
  local row = _let_7_[1]
  local col = _let_7_[2]
  local stack = nvim.fn.synstack(row, a.inc(col))
  local stack_size = #stack
  local function _8_()
    local name = nvim.fn.synIDattr(stack[stack_size], "name")
    return (name:find("Comment$") or name:find("String$") or name:find("Regexp%?$"))
  end
  if (("number" == type(((stack_size > 0) and _8_()))) or ("\\" == string.sub(a.first(nvim.buf_get_lines(nvim.win_get_buf(0), (row - 1), row, false)), col, col))) then
    return 1
  else
    return 0
  end
end
_2amodule_2a["skip-match?"] = skip_match_3f
local function current_char()
  local _let_10_ = nvim.win_get_cursor(0)
  local row = _let_10_[1]
  local col = _let_10_[2]
  local _let_11_ = nvim.buf_get_lines(0, (row - 1), row, false)
  local line = _let_11_[1]
  local char = (col + 1)
  return string.sub(line, char, char)
end
_2amodule_locals_2a["current-char"] = current_char
local function distance_gt(_12_, _14_)
  local _arg_13_ = _12_
  local al = _arg_13_[1]
  local ac = _arg_13_[2]
  local _arg_15_ = _14_
  local bl = _arg_15_[1]
  local bc = _arg_15_[2]
  return ((al > bl) or ((al == bl) and (ac > bc)))
end
_2amodule_locals_2a["distance-gt"] = distance_gt
local function range_distance(range)
  local _let_16_ = range.start
  local sl = _let_16_[1]
  local sc = _let_16_[2]
  local _let_17_ = range["end"]
  local el = _let_17_[1]
  local ec = _let_17_[2]
  return {(sl - el), (sc - ec)}
end
_2amodule_locals_2a["range-distance"] = range_distance
local function comment_form_3f(_18_)
  local _arg_19_ = _18_
  local content = _arg_19_["content"]
  local _21_
  do
    local _20_ = content:find("^%(comment[%s$]")
    _21_ = _20_
  end
  return (1 == _21_)
end
_2amodule_locals_2a["comment-form?"] = comment_form_3f
local function make_skip_first(n, char)
  local count = n
  local function skip_first()
    if (0 < skip_match_3f()) then
      return 1
    else
      if ((char == current_char()) and (0 < count)) then
        count = a.dec(count)
        return 1
      else
        return 0
      end
    end
  end
  return skip_first
end
_2amodule_locals_2a["make-skip-first"] = make_skip_first
local function depth_form(_24_, depth)
  local _arg_25_ = _24_
  local start_char = _arg_25_[1]
  local end_char = _arg_25_[2]
  local escape_3f = _arg_25_[3]
  local depth0 = (depth or 0)
  local flags = "Wnz"
  local cursor_char = current_char()
  local safe_start_char
  if escape_3f then
    safe_start_char = ("\\" .. start_char)
  else
    safe_start_char = start_char
  end
  local safe_end_char
  if escape_3f then
    safe_end_char = ("\\" .. end_char)
  else
    safe_end_char = end_char
  end
  local start
  local function _28_()
    if (cursor_char == start_char) then
      return "c"
    else
      return ""
    end
  end
  start = nvim.fn.searchpairpos(safe_start_char, "", safe_end_char, (flags .. "b" .. _28_()), make_skip_first(depth0, safe_start_char))
  local _end
  local function _29_()
    if (cursor_char == end_char) then
      return "c"
    else
      return ""
    end
  end
  _end = nvim.fn.searchpairpos(safe_start_char, "", safe_end_char, (flags .. _29_()), make_skip_first(depth0, safe_end_char))
  if (not nil_pos_3f(start) and not nil_pos_3f(_end)) then
    return {range = {start = {a.first(start), a.dec(a.second(start))}, ["end"] = {a.first(_end), a.dec(a.second(_end))}}, content = read_range(start, _end)}
  else
    return nil
  end
end
_2amodule_locals_2a["depth-form"] = depth_form
local function sort_forms(forms)
  local function _31_(_241, _242)
    return distance_gt(range_distance(_241.range), range_distance(_242.range))
  end
  table.sort(forms, _31_)
  return forms
end
_2amodule_locals_2a["sort-forms"] = sort_forms
local function depth_forms(depth)
  local function _32_(_241)
    return depth_form(_241, depth)
  end
  return sort_forms(a.filter(a["table?"], a.map(_32_, config["get-in"]({"extract", "form_pairs"}))))
end
_2amodule_2a["depth-forms"] = depth_forms
local function lc_3d(x, y)
  return ((a.first(x) == a.first(y)) and (a.second(x) == a.second(y)))
end
_2amodule_locals_2a["lc="] = lc_3d
local function forms_3d(x, y)
  return (x and y and (a.get(x, "content") == a.get(y, "content")) and lc_3d(a["get-in"](x, {"range", "start"}), a["get-in"](y, {"range", "start"})) and lc_3d(a["get-in"](x, {"range", "end"}), a["get-in"](y, {"range", "end"})))
end
_2amodule_locals_2a["forms="] = forms_3d
local function has_form_3f(forms, form)
  local found_3f = false
  local i = 1
  while (not found_3f and (i <= #forms)) do
    found_3f = forms_3d(form, a.get(forms, i))
    i = a.inc(i)
  end
  return found_3f
end
_2amodule_locals_2a["has-form?"] = has_form_3f
local function form_tree()
  local root = searchpair.form({["root?"] = true})
  local forms = {root}
  local depth = -1
  local found_root_3f = false
  local inserted_3f = true
  while inserted_3f do
    depth = a.inc(depth)
    inserted_3f = false
    for _, dform in ipairs(depth_forms(depth)) do
      if forms_3d(root, dform) then
        found_root_3f = true
      elseif not has_form_3f(forms, dform) then
        table.insert(forms, dform)
        inserted_3f = true
      else
      end
    end
  end
  return sort_forms(forms)
end
_2amodule_locals_2a["form-tree"] = form_tree
--[[ (form-tree) {:a (form-tree)} {:thekey (do [(do (form-tree))])} (do (tostring "OK") (form-tree)) ]]--
local function effective_root_form()
  local tree = form_tree()
  local f = a.last(tree)
  while (f and comment_form_3f(f)) do
    tree = a.butlast(tree)
    f = a.last(tree)
  end
  return f
end
_2amodule_2a["effective-root-form"] = effective_root_form
--[[ (effective-root-form) {:a (effective-root-form)} {:thekey (do [(do (effective-root-form))])} (do (comment [{:foo (do [(do (effective-root-form))])}])) (do (tostring "OK") (effective-root-form)) ]]--
return _2amodule_2a