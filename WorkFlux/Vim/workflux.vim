"%% SiSU Vim color file
" Modified by eXpander (2018-02-06)
" Slate Maintainer: Ralph Amissah <ralph@amissah.com>
" (originally looked at desert Hans Fugal <hans@fugal.net> http://hans.fugal.net/vim/colors/desert.vim (2003/05/06)
:set background=dark
:highlight clear
if version > 580
 hi clear
 if exists("syntax_on")
 syntax reset
 endif
endif
let colors_name = "workflux"
:hi Normal guifg=White guibg=grey15 ctermfg=7
:hi Cursor guibg=khaki guifg=slategrey
:hi VertSplit guibg=#c2bfa5 guifg=grey40 gui=none cterm=reverse
:hi Folded guibg=black guifg=grey40 ctermfg=grey ctermbg=darkgrey
:hi FoldColumn guibg=black guifg=grey20 ctermfg=4 ctermbg=0
:hi IncSearch guifg=green guibg=black cterm=none ctermfg=yellow ctermbg=green
:hi ModeMsg guifg=goldenrod cterm=none ctermfg=brown
:hi MoreMsg guifg=SeaGreen ctermfg=darkgreen
:hi NonText guifg=RoyalBlue guibg=grey15 cterm=bold ctermfg=blue
:hi Question guifg=springgreen ctermfg=green
:hi Search guibg=peru guifg=wheat cterm=none ctermfg=grey ctermbg=blue
:hi SpecialKey guifg=yellowgreen ctermfg=darkgreen
:hi StatusLine guibg=#c2bfa5 guifg=black gui=none ctermfg=0 cterm=bold
:hi StatusLineNC guibg=#c2bfa5 guifg=grey40 gui=none cterm=reverse
:hi Title guifg=gold gui=bold cterm=bold ctermfg=yellow
:hi Statement guifg=CornflowerBlue ctermfg=2 cterm=bold
:hi Visual gui=none guifg=khaki guibg=olivedrab cterm=reverse
:hi WarningMsg guifg=salmon ctermfg=1
:hi String guifg=SkyBlue ctermfg=11
:hi Comment cterm=none ctermfg=6 guifg=grey40
:hi Constant guifg=#ffa0a0 ctermfg=3
:hi Special guifg=darkkhaki ctermfg=4
:hi Identifier guifg=salmon ctermfg=3 cterm=bold
:hi Include guifg=red ctermfg=3 cterm=bold
:hi PreProc guifg=red guibg=white cterm=bold ctermfg=6
:hi Operator guifg=Red ctermfg=3 cterm=bold
:hi Define guifg=gold gui=bold ctermfg=3 cterm=bold
:hi Type guifg=CornflowerBlue ctermfg=2 cterm=bold
:hi Function guifg=navajowhite ctermfg=4 cterm=bold
:hi Structure guifg=green ctermfg=green
:hi LineNr guifg=grey50 ctermfg=15 cterm=none
:hi Ignore guifg=grey40 cterm=bold ctermfg=0
:hi Todo guifg=orangered guibg=yellow2
:hi Directory ctermfg=darkcyan
:hi ErrorMsg cterm=bold guifg=White guibg=Red cterm=bold ctermfg=0 ctermbg=1
:hi VisualNOS cterm=bold,underline
:hi WildMenu ctermfg=0 ctermbg=2 cterm=none
:hi DiffAdd ctermbg=4
:hi DiffChange ctermbg=5
:hi DiffDelete cterm=bold ctermfg=4 ctermbg=6
:hi DiffText cterm=bold ctermbg=1
:hi Underlined cterm=underline ctermfg=5
:hi Error guifg=White guibg=Red cterm=bold ctermfg=0 ctermbg=1
:hi SpellErrors guifg=White guibg=Red cterm=bold ctermfg=0 ctermbg=1
