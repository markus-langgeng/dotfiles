-- Does each package have difference output on each document type
-- or does each group of some package have difference output on each document type

local packages = {
    geometry = [[\usepackage{geometry}]], -- \geometry{a5paper,left=3cm,...}

    polyglossia = [[\usepackage{polyglossia}]],
    fontspec = [[\usepackage{fontspec}]],
    xeCJK = [[\usepackage{xeCJK}]],
    xpinyin = [[\usepackage{xpinyin}]],

    microtype = [[\usepackage{microtype}                    % subliminal refinements]],
    indentfirst = [[\usepackage{indentfirst}                % self explanatory]],
    parskip = [[\usepackage[skip=0pt,indent=30pt]{parskip}  % paragraph spacing]],
    setspace = [[\usepackage{setspace}                      % line spacing. \onehalfspacing]],

    titling = [[\usepackage{titling}                        % customize \maketitle and \thanks]],

    -- can be used together with titling
    fancyhdr = [[\usepackage{fancyhdr}                      % user-friendlier way to customize header compare to titlesec]],

    -- can couse conflict if used together with titling or fancyhdr
    titlesec = [[\usepackage{titlesec,titleps,titletoc}     % customize chapters, sections, subsections. \titleformat, \titlespacing]],

    multicol = [[\usepackage{multicol}]],

    import = [[\usepackage{import}]],

    graphicx = [[\usepackage{graphicx}]],
    tikz = [[\usepackage{tikz}]],

    biblatex = [[\usepackage{biblatex}]],
    caption = [[\usepackage{caption}]],
    subcaption = [[\usepackage{subcaption}]],
    hyperref = [[\usepackage{hyperref}]],
}

local package_group = {
    layout = {},
    language = {}, -- automatically comes with font settings
    paragraph = {},
    references = {},
    addimage = {},
}

--
-- packages.geometry.default = [[\usepackage[a4paper,left=3cm,top=3cm,right=3cm,bottom=3cm,]{geometry}]]
-- packages.geometry.tugas = [[\usepackage[a4paper,left=3cm,top=3cm,right=3cm,bottom=3cm,]{geometry}]]
-- packages.geometry.makalah = [[\usepackage[a4paper,left=4cm,top=3cm,right=3cm,bottom=3cm,]{geometry}]]
-- packages.geometry.catatan = [[\usepackage[a5paper,left=1cm,top=1cm,right=1cm,bottom=1cm,]{geometry}]]
--
-- packages.polyglossia.default = [[
-- \usepackage{polyglossia}
-- \setdefaultlanguage[variant=indonesian]{malay}
-- \setdefaultlanguages{english,}
-- ]]
--
-- packages.fontspec.default = [[\usepackage{fontspec}]]
-- packages.fontspec.tugas = [[
-- \usepackage{fontspec}
-- \setmainfont{Times New Roman} % Liberation Serif
-- \setsansfont{Arial} % Liberation Sans
-- \setmonofont{Courier New} % Liberation Mono
-- ]]
-- packages.fontspec.makalah = [[
-- \usepackage{fontspec}
-- \setmainfont{Times New Roman} % Liberation Serif
-- \setsansfont{Arial} % Liberation Sans
-- \setmonofont{Courier New} % Liberation Mono
-- ]]
-- packages.fontspec.catatan = [[
-- \usepackage{fontspec}
-- \setmainfont{Liberation Serif} % Times New Roman
-- \setsansfont{Liberation Sans} % Arial
-- \setmonofont{Liberation Mono} % Courier New
-- ]]
--
-- packages.xeCJK.default = [[\usepackage{xeCJK}]]
-- packages.xpinyin.default = [[
-- \usepackage{xpinyin}
-- \xpinyinsetup{ratio={.6}, hsep={.6em plus .1em}, pysep={}}
-- \setCJKmainfont{Noto Serif CJK SC}
-- \setCJKsansfont{Noto Sans CJK SC}
-- \setCJKmonofont{Noto Sans Mono CJK SC}
-- ]]
--
-- packages.microtype.default = [[\usepackage{microtype}]]
-- packages.setspace.default = [[
-- \usepackage{setspace}
-- \onehalfspacing
-- ]]
-- packages.indentfirst.default = [[\usepackage{indentfirst}]]
-- packages.titlesec.default = [[\usepackage{titlesec}]]
-- packages.titling.default = [[\usepackage{titling}]]
-- packages.titletoc.default = [[\usepackage{titletoc}]]
-- packages.parskip.default = [[\usepackage[indent=30pt,skip=0pt]{parskip}]]
--
-- packages.caption.default = [[\usepackage{caption}]]
-- packages.subaption.default = [[\usepackage{subcaption}]]
--
-- packages.graphicx.default = [[
-- \usepackage{garphicx}
-- \graphicspath{ {/home/nggeng/.local/share/commonly_used_images/} }
-- ]]
--
-- packages.biblatex.default = [[
-- \usepackage[backend=biber,style=authoryear,hyperref=true,]{biblatex}
-- \addbibresource{ref.bib}
-- ]]
--
-- packages.hyperref.default = [[
-- \usepackage{hyperref}
-- \hypersetup{colorlinks=false,citecolor=blue,linkcolor=blue,urlcolor=blue}
-- \urlstyle={same}
-- ]]

local M = {}

return M
