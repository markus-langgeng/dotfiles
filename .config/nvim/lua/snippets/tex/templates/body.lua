local M = {}

M.maketitle = function ()
    return [[\maketitle]]
end

M.titlepage = function ()
    local res = [[
    \begin{titlepage}

        \begin{center}
            \textbf{\thetitle}

            Subjudul Makalah

            \textbf{\theauthor}

            \vfill
            \includegraphics[scale=.4]{logo_ub.png}
            \vfill

            Fakultas Ilmu Budaya\\
            Universitas Brawijaya\\
            Indonesia\\
            \today
        \end{center}

    \end{titlepage}
    ]]

    return res
end

M.build_body = function ()
    local res = string.format([[
    \begin{document}
    %s

    <>
    \end{document}
    ]], "\\maketitle")

    return res
end


return M
