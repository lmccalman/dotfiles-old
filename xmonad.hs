-- Import statements
import XMonad
import XMonad.Hooks.DynamicLog     -- for xmobar
import XMonad.Hooks.ManageDocks    -- for trayer?
import XMonad.Layout.NoBorders     -- (7)  get rid of borders sometimes
import XMonad.Layout.Fullscreen
import XMonad.Layout.Named
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.GridSelect
import XMonad.Hooks.EwmhDesktops  -- tell panels about desktops
import System.IO




myTerminal = "urxvtcd"
myWorkspaces = ["1","2","3","4","5"]
myLayoutHook = avoidStruts ( tiled ||| htiled ||| four ) ||| fullscreen  
    where 
      tiled = smartBorders ( Tall nmaster delta ratio )
      htiled = smartBorders ( Mirror $ Tall nmaster delta ratio )
      four   = smartBorders ( named "Grid" $ Tall 2 delta ratio )
      fullscreen = noBorders ( fullscreenFull Full )
      nmaster = 1
      delta = 5/100
      ratio = 1/2

-- for class and resource name run "xprop WM_CLASS" at terminal then click
-- window... see xmonad FAQ also
-- better than that, I have a script in environ
myManageHook = composeAll
    [ className =? "Xfce4-notifyd"  --> doIgnore
    , className =? "Gimp"           --> doFloat
    , appName   =? "Download"       --> doFloat
    , appName   =? "anki"           --> doFloat
    , title =? "Transferring"       --> doFloat
    ]
 
-- Run XMonad
main = do
    xmproc <- spawnPipe "/usr/bin/tint2 -c /home/lb/.tint2rc"
    xmonad $ ewmh defaultConfig 
        { terminal = myTerminal
        , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
		, layoutHook = myLayoutHook
		, borderWidth         = 1
    , workspaces          = myWorkspaces
		, normalBorderColor   = "#262626"
		, focusedBorderColor  = "#efefaf"
		, modMask             = mod4Mask
        } `additionalKeys`
        [ ((mod4Mask, xK_f), spawn "firefox")
         ,((mod4Mask, xK_d), spawn "dolphin")
         ,((mod4Mask, xK_g), goToSelected defaultGSConfig) 
        ]
