function escape_latex(str)
    return str:gsub("\\", "\\textbackslash ")
        :gsub("([%%%$#_{}~^&])", "\\%1")
        :gsub("_", "\\_")
end

function load_datasets(filename)
    local file = io.open(filename, "r")
    local content = file:read("*all")
    file:close()
    return utilities.json.tolua(content)
end