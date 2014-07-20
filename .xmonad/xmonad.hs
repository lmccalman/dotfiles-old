-- Import statements
import XMonad
import XMonad.Hooks.ManageDocks    -- for trayer?
import XMonad.Hooks.Place
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.WindowProperties     -- propertyToQuery TESTING

--import XMonad.Layout.Fullscreen
import XMonad.Layout.Named
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.Gaps               -- gaps
import XMonad.Layout.Renamed            -- modify layout names
import XMonad.Layout.Minimize           -- minimization
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Fullscreen

import XMonad.Actions.CycleWS           -- toggle workspace
import XMonad.Actions.SpawnOn           -- spawn on specific workspace

import qualified XMonad.StackSet as W
import XMonad.Actions.GridSelect
import System.IO

-- Run XMonad
main = do
  status <- spawnPipe myDzenStatus
  action <- spawnPipe myDzenAction
  conky <- spawnPipe myDzenConky
  xmonad $ defaultConfig 
    { terminal = myTerminal
    , manageHook = manageSpawn <+> manageDocks <+> myManageHook <+> manageHook defaultConfig
    , layoutHook = myLayoutHook
    , borderWidth         = 0
    , workspaces          = myWorkspaces
    , normalBorderColor   = "#000000"
    , focusedBorderColor  = "#000000"
    , logHook = myLogHook status <+> fadeWindowsLogHook myFadeHook
    , handleEventHook = fadeWindowsEventHook <+> fullscreenEventHook
    , modMask             = mod4Mask
    } `additionalKeys`
        [ ((mod4Mask, xK_f), spawn "firefox")
        ,((mod4Mask, xK_d), spawn "dolphin")
        ,((mod4Mask, xK_v), spawn "gvim")
        ,((mod4Mask, xK_g), goToSelected defaultGSConfig) 
        ]

-- Dzen
myLogHook h = dynamicLogWithPP $ myDzenPP { ppOutput = hPutStrLn h }
myDzenStatus = "dzen2 -x '0' -w '1100' -ta 'l' -dock" ++ myDzenStyle
myDzenAction = "conky -c ~/.actionconkyrc | dzen2 -x '1100' -w '330' -ta 'c' -dock" ++ myDzenStyle
myDzenConky  = "conky -c ~/.conkyrc | dzen2 -x '1430' -w '394' -ta 'r' -dock" ++ myDzenStyle
myDzenStyle  = " -h '16' -y '0' -fn terminus -fg '#777777' -bg '#222222'"
myDzenPP = dzenPP
    { ppCurrent = dzenColor "#3E5EB5" "" . wrap " " " "
    , ppHidden  = dzenColor "#aaaaaa" "" . wrap " " " "
    , ppHiddenNoWindows = dzenColor "#666666" "" . wrap " " " "
    , ppUrgent  = dzenColor "#ff0000" "" . wrap " " " "
    , ppSep     = "  "
    , ppLayout  = \y -> ""
    , ppTitle   = dzenColor "#088a29" "" . wrap " " " "
    }

-- Placement of floats
-- withGaps (top, right, bottom, left) forbidden areas from screen border in pixels
-- smart (x-pos, y-pos) prefered placement position in fraction of 1
myPlacement = withGaps (0, 0, 40, 0) $ smart (0.973,1)


myTerminal = "urxvtc"
myWorkspaces = ["1","2","3","4","5"]
myLayoutHook = avoidStruts ( tiled ||| htiled ||| four ) ||| fullscreen
    where 
      tiled = smartSpacing 6 $ smartBorders ( Tall nmaster delta ratio )
      htiled = smartSpacing 6 $ smartBorders ( Mirror $ Tall nmaster delta ratio )
      four   = smartSpacing 6 $ smartBorders ( named "Grid" $ Tall 2 delta ratio )
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
    , title =? "Steam"              --> doFloat
    , className =? "Steam"          --> doFloat
    ]
 
-- Transparancy
myFadeHook = composeAll
        [ opaque
        -- , className =? "Skype" --> transparency 0.2
        , isUnfocused --> transparency 0.2
        , className =? "Chromium" <&&> isUnfocused --> transparency 0.1
        , className =? "URxvt" <&&> isUnfocused --> transparency 0.23
        , className =? "Skype" <&&> isUnfocused --> transparency 0.3
        , className =? "MuPDF" <&&> isUnfocused --> transparency 0.1
        , className =? "Okular" <&&> isUnfocused --> transparency 0.1
        , className =? "TexMaker" <&&> isUnfocused --> transparency 0.1
        , className =? "Thunderbird" <&&> isUnfocused --> transparency 0.1
        , className =? "MPlayer" <&&> isUnfocused --> transparency 0
        , className =? "Gimp" <&&> isUnfocused --> transparency 0
        ]


