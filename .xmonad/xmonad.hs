---------------------------------------------------------------------------
--                                                                       --
--     _|      _|  _|      _|                                      _|    --
--       _|  _|    _|_|  _|_|    _|_|    _|_|_|      _|_|_|    _|_|_|    --
--         _|      _|  _|  _|  _|    _|  _|    _|  _|    _|  _|    _|    --
--       _|  _|    _|      _|  _|    _|  _|    _|  _|    _|  _|    _|    --
--     _|      _|  _|      _|    _|_|    _|    _|    _|_|_|    _|_|_|    --
--                                                                       --
---------------------------------------------------------------------------

    -- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll)
import qualified XMonad.Actions.Search as S

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isDialog, isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

    -- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

   -- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

import Graphics.X11.ExtraTypes.XF86


-- ## Settings ## -------------------------------------------------------------------

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

-- Mod key to use
-- mod1Mask : left alt Key
-- mod4Mask : Windows or Super Key
myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "kitty"

myEditor :: String
myEditor = "emacsclient -c -a 'emacs' "  -- Sets emacs as editor

-- Focus follows the mouse pointer
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Clicking on a window to focus
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels
myBorderWidth :: Dimension
myBorderWidth = 2

-- Border color for focused windows
myFocusedColor :: String
myFocusedColor = "#c678dd"

-- Border color for unfocused windows
myNormalColor :: String
myNormalColor = "#282c34"

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def
    { fontName            = myFont
    , activeColor         = "#c678dd"
    , inactiveColor       = "#282c34"
    , activeBorderColor   = "#c678dd"
    , inactiveBorderColor = "#282c34"
    , activeTextColor     = "#282c34"
    , inactiveTextColor   = "#d0d0d0"
    }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

-- Layouts
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.

-- Workspaces (ewmh)
myWorkspaces = [" dev ", " sys ", " www ", " aux ", " comm ", " misc "]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

-- The layout hook
myLayoutHook = avoidStruts
    $ mouseResize
    $ windowArrange
    $ T.toggleLayouts floats
    $ onWorkspace " www " (noBorders tabs)
    $ onWorkspace " comm " (noBorders tabs)
    $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
    where
        myDefaultLayout = tall
            ||| wide
            -- ||| magnify
            ||| noBorders monocle
            -- ||| floats
            ||| noBorders tabs
        tall = renamed [Replace "tall"]
            $ lessBorders Screen
            $ windowNavigation
            $ addTabs shrinkText myTabTheme
            $ subLayout [] (smartBorders Simplest)
            $ limitWindows 12
            $ mySpacing 4
            $ ResizableTall 1 (3/100) (1/2) []
        wide = renamed [Replace "wide"]
            $ lessBorders Screen
            $ windowNavigation
            $ addTabs shrinkText myTabTheme
            $ subLayout [] (smartBorders Simplest)
            $ limitWindows 12
            $ mySpacing 4
            $ Mirror
            $ (ResizableTall 1 (3/100) (1/2) [])
        monocle = renamed [Replace "monocle"]
            $ lessBorders Screen
            $ windowNavigation
            $ addTabs shrinkText myTabTheme
            $ subLayout [] (smartBorders Simplest)
            $ limitWindows 20 Full
        tabs = renamed [Replace "tabs"]
            $ tabbed shrinkText myTabTheme
        floats = renamed [Replace "floats"]
            $ lessBorders Screen
            $ limitWindows 20 simplestFloat


-- Startup hook
myStartupHook :: X ()
myStartupHook = do
    spawn "~/.xmonad/autostart.sh"
    setWMName "LG3D"

-- Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset


-- ## Key Bindings ## -------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

-- KB_GROUP Xmonad
    [ ((mod1Mask .|. shiftMask, xK_r),      spawn "xmonad --recompile; xmonad --restart") -- Restarts xmonad
    , ((mod1Mask .|. shiftMask, xK_q),      io exitSuccess)                               -- Quits xmonad

-- KB_GROUP Run Prompt
    , ((mod1Mask,               xK_space),  spawn "~/.config/rofi/scripts/launcher")

-- KB_GROUP Useful programs to have a keybinding for launch
    , ((mod1Mask,               xK_Return), spawn (myTerminal))
    , ((mod1Mask .|. shiftMask, xK_Return), spawn (myTerminal ++ " -e tmux new-session -A -s 'Default'"))
    , ((modMask,                xK_e),      spawn (myEditor))
    , ((modMask,                xK_r),      spawn (myTerminal ++ " -e ~/.local/bin/lf"))
    , ((mod1Mask,               xK_0),      spawn "~/.config/rofi/scripts/powermenu")
    , ((modMask .|. shiftMask,  xK_s),      spawn "gnome-screenshot --interactive")
    , ((mod1Mask .|. shiftMask, xK_c),      spawn "~/.config/rofi/scripts/clipmenu")
    , ((mod1Mask .|. shiftMask, xK_w),      spawn "~/.config/rofi/scripts/windows")
    , ((mod1Mask .|. shiftMask, xK_0),      spawn "~/.config/rofi/scripts/calc")
    , ((mod1Mask .|. shiftMask, xK_a),      spawn "cinnamon-settings sound")
    -- , ((mod1Mask .|. shiftMask, xK_a),      spawn "~/.config/rofi/scripts/audio-set-default-sink")

-- KB_GROUP Kill windows
    , ((mod1Mask,               xK_q),      kill1)
    , ((modMask,                xK_q),      spawn "xkill")

-- KB_GROUP Windows navigation
    , ((mod1Mask,               xK_m),      windows W.focusMaster)  -- Move focus to the master window
    , ((mod1Mask,               xK_j),      windows W.focusDown)    -- Move focus to the next window
    , ((mod1Mask,               xK_k),      windows W.focusUp)      -- Move focus to the prev window
    , ((mod1Mask .|. shiftMask, xK_m),      windows W.swapMaster)   -- Swap the focused window and the master window
    , ((mod1Mask .|. shiftMask, xK_j),      windows W.swapDown)     -- Swap focused window with next window
    , ((mod1Mask .|. shiftMask, xK_k),      windows W.swapUp)       -- Swap focused window with prev window

-- KB_GROUP Layouts
    , ((modMask,                xK_space),  sendMessage NextLayout)             -- Switch to next layout
    , ((modMask .|. shiftMask,  xK_space),  setLayout $ XMonad.layoutHook conf) -- Reset layout on current ws to default

-- KB_GROUP Hardware Keys
    , ((0, xF86XK_MonBrightnessUp),   spawn "brightnessctl -c backlight set 5%+ && ~/.local/bin/brightness-notification.sh")
    , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl -c backlight set 5%- && ~/.local/bin/brightness-notification.sh")

    , ((0, xF86XK_AudioRaiseVolume),  spawn "amixer set Master 5%+ && ~/.local/bin/audio-notification.sh")
    , ((0, xF86XK_AudioLowerVolume),  spawn "amixer set Master 5%- && ~/.local/bin/audio-notification.sh")
    , ((0, xF86XK_AudioMute),         spawn "amixer set Master toggle && ~/.local/bin/audio-notification.sh")

    -- Shrink the master area
    , ((modMask, xK_minus), sendMessage Shrink)

    -- Expand the master area
    , ((modMask, xK_plus), sendMessage Expand)

    -- Increment the number of windows in the master area
    , ((modMask, xK_period), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask, xK_comma), sendMessage (IncMasterN (-1)))
    ]
    ++

-- Workspace Specific ---------------------------------------------------------------

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. mod1Mask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{1,2,3}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{1,2,3}, Move client to screen 1, 2, or 3
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_1, xK_2, xK_3] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- ## Mouse Bindings ## ------------------------------------------------------------------
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

-- ## Window rules ## --------------------------------------------------------------------
myManageHook = composeAll . concat $
    [ [isDialog --> doCenterFloat]
    , [className =? c --> doCenterFloat | c <- myCFloats]
    , [title     =? t --> doCenterFloat | t <- myTFloats]
    , [resource  =? r --> doFloat | r <- myRFloats]
    , [resource  =? i --> doIgnore | i <- myIgnores]

    , [className =? "Alacritty"           --> doShift ( myWorkspaces !! 0 )]
    , [className =? "Kitty"               --> doShift ( myWorkspaces !! 0 )]
    , [className =? "Thunar"              --> doShift ( myWorkspaces !! 1 )]
    , [className =? "firefox"             --> doShift ( myWorkspaces !! 2 )]
    , [className =? "microsoft-edge-beta" --> doShift ( myWorkspaces !! 2 )]
    , [className =? "Slack"               --> doShift ( myWorkspaces !! 3 )]
    ]
    where
        myCFloats = ["Yad"]
        myTFloats = ["Downloads", "Save As...", "Getting Started"]
        myRFloats = ["Gcolor3"]
        myIgnores = ["desktop_window", "panel"]

-- ## Event handling ## -------------------------------------------------------------------
myEventHook = docksEventHook


-- ## Main Function ## --------------------------------------------------------------------

-- Run xmonad with all the configs we set up.
main :: IO ()
main = do
    -- Launching three instances of xmobar on their monitors.
    xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/doom-one-xmobarrc"
    -- xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.config/xmobar/doom-one-xmobarrc"
    -- xmproc2 <- spawnPipe "xmobar -x 2 $HOME/.config/xmobar/doom-one-xmobarrc"
    -- the xmonad, ya know...what the WM is named after!
    xmonad $ ewmh def
        { terminal           = myTerminal

        -- configs
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalColor
        , focusedBorderColor = myFocusedColor

        -- key bindings
        , keys               = myKeys
        , mouseBindings      = myMouseBindings

        -- hooks, layouts
        , manageHook         = insertPosition End Newer <+> myManageHook
        , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
        , handleEventHook    = myEventHook
        , startupHook        = myStartupHook
        , logHook            = dynamicLogWithPP $ xmobarPP
            -- the following variables beginning with 'pp' are settings for xmobar.
            { ppOutput = \x -> hPutStrLn xmproc0 x                          -- xmobar on monitor 1
                            -- >> hPutStrLn xmproc1 x                          -- xmobar on monitor 2
                            -- >> hPutStrLn xmproc2 x                          -- xmobar on monitor 3
            , ppCurrent = xmobarColor "#c792ea" "" . wrap "<box type=Bottom width=2 mb=2 color=#c792ea>" "</box>"         -- Current workspace
            , ppVisible = xmobarColor "#c792ea" "" . clickable              -- Visible but not current workspace
            , ppHidden = xmobarColor "#82AAFF" "" . wrap "<box type=Top width=2 mt=2 color=#82AAFF>" "</box>" . clickable -- Hidden workspaces
            , ppHiddenNoWindows = xmobarColor "#82AAFF" ""  . clickable     -- Hidden workspaces (no windows)
            , ppTitle = xmobarColor "#b3afc2" "" . shorten 60               -- Title of active window
            , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"                    -- Separator character
            , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"            -- Urgent workspace
            , ppExtras  = [windowCount]                                     -- # of windows current workspace
            , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
            }
        }
