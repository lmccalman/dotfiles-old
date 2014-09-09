-- Import statements
import XMonad
import XMonad.Hooks.ManageDocks    -- for trayer?
import XMonad.Hooks.EwmhDesktops hiding (fullscreenEventHook)
import XMonad.Hooks.Place
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
  xmonad $ ewmh defaultConfig 
    { terminal = myTerminal
    , manageHook = manageSpawn <+> manageDocks <+> myManageHook <+> manageHook defaultConfig
    , layoutHook = myLayoutHook
    , borderWidth         = 6
    , workspaces          = myWorkspaces
    , normalBorderColor   = "#000000"
    , focusedBorderColor  = "#880000"
    , logHook = myLogHook status 
    , handleEventHook = fullscreenEventHook
    , modMask             = mod4Mask
    } `additionalKeys`
        [ ((mod4Mask, xK_f), spawn "firefox")
        ,((mod4Mask, xK_d), spawn "dolphin")
        ,((mod4Mask, xK_v), spawn "gvim")
        ,((mod4Mask, xK_g), goToSelected defaultGSConfig) 
        ]

-- Dzen
myLogHook h = dynamicLogWithPP $ myDzenPP { ppOutput = hPutStrLn h }
myDzenStatus = "dzen2 -x '0' -w '1900' -ta 'l' -dock" ++ myDzenStyle
myDzenAction = "conky -c ~/.actionconkyrc | dzen2 -x '1900' -w '600' -ta 'c' -dock" ++ myDzenStyle
myDzenConky  = "conky -c ~/.conkyrc | dzen2 -x '2500' -w '444' -ta 'r' -dock" ++ myDzenStyle
myDzenStyle  = " -h '32' -y '0' -fn 'Anonymous Pro-18' -fg '#777777' -bg '#222222'"
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
 
