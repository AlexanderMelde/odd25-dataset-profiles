function escapeLatex(str)
    return str:gsub("\\", "\\textbackslash ")
        :gsub("([%%%$#_{}~^&])", "\\%1")
        :gsub("_", "\\_")
end

function loadJson(filename)
    local file = io.open(filename, "r")
    local content = file:read("*all")
    file:close()
    local lua = utilities.json.tolua(content)
    if not lua then
        tex.print([[\textbf{Fehler: Konnte ]] .. filename .. [[ nicht laden!}]])
        error()
    end
    return lua
end

function centeredImage(filename)
    local wrapperBegin = [[\begin{center}]]
    
    local image = (filename and filename ~= "")  
            and [[\includegraphics[width=\textwidth,height=8cm,keepaspectratio]{]] .. filename .. [[}]]
            or [[\framebox[\textwidth][c]{\parbox{8cm}{\centering Bildplatzhalter}}]]
            
    local wrapperEnd = [[\end{center}  \leavevmode\\ ]]

    return (wrapperBegin .. image .. wrapperEnd) 
end

function outputLatex(str)
    local output_cleaned, _ = str :gsub("[\n\r]", " ")
    tex.print(output_cleaned)
end

function downloadWithQRCode(url)
    return [[
        \url{]] .. url .. [[} \\
        \begin{center}
            \qrcode[height=3cm]{]] .. escapeLatex(url) .. [[}
        \end{center}
    ]]
end