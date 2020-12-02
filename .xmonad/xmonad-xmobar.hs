import XMonad

import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.Navigation2D
import XMonad.Actions.Promote
import XMonad.Actions.WindowMenu

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Util.NamedWindows (getName)
import XMonad.Util.Run

import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed

import Control.Monad (forM_, join)

import Data.Function (on)
import Data.List (sortBy)
import Data.Ratio

import Graphics.X11.ExtraTypes.XF86

import System.Exit

import qualified XMonad.Prompt         as P
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Actions.Search as S
import qualified XMonad.StackSet       as W

import qualified DBus                     as D
import qualified DBus.Client              as D
import qualified Data.Map                 as M
import qualified Codec.Binary.UTF8.String as UTF8


-----------------------------------------------------------------------------}}}
-- LOCAL VARIABLES                                                           {{{
--------------------------------------------------------------------------------
-- General config
myWorkspaces    = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
myModMask       = mod1Mask
myTerminal      = "alacritty"
myBorderWidth   = 2
myWindowSpacing = 5
myBrowser       = "firefox"
myWindowCount   = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Fonts
myFont       = "xft:Monospace:size=16"

-- Colors
cFocus    = "#51afef"
cNormal   = "#928374"
cUrgent   = "#bf616a"

cBlue      = "#868bae"
cGreen     = "#00d700"
cRed       = "#ff005f"
cGray      = "#666666"
-- cWhite    = "#ffffff"
cWhite     = "#bdbdbd"
cNormalBg  = "#1c1c1c"
cNormalFg  = "#a8b6b8"

-----------------------------------------------------------------------------}}}
-- CONFIG                                                                    {{{
--------------------------------------------------------------------------------
myConfig = def
    { modMask             = myModMask
    , terminal            = myTerminal
    , focusFollowsMouse   = False
    , clickJustFocuses    = False
    , workspaces          = myWorkspaces
    , borderWidth         = myBorderWidth
    , normalBorderColor   = cNormal
    , focusedBorderColor  = cFocus
    , keys                = myKeys
    , startupHook         = myStartupHook
    , manageHook          = insertPosition Below Newer <+> myManageHook
    , layoutHook          = myLayoutHook
    }


myTabConfig = def
    { fontName            = myFont
    , decoHeight          = 30
    , activeColor         = cFocus
    , activeBorderColor   = cFocus
    , inactiveColor       = cNormal
    , inactiveBorderColor = cNormal
    -- , activeTextColor   = "#000000"
    }

myTheme = Theme {
    activeColor         = cFocus
  , inactiveColor       = cNormal
  , urgentColor         = "#ffff00"
  , inactiveBorderColor = cNormal
  , activeBorderColor   = cFocus
  , urgentBorderColor   = "#00ff00"
  , activeTextColor     = "white"
  , inactiveTextColor   = "black"
  , urgentTextColor     = "#FF0000"
  , fontName            = myFont
  , decoWidth           = 200
  , decoHeight          = 40
  , windowTitleAddons   = []
  , windowTitleIcons    = []
  }


-----------------------------------------------------------------------------}}}
-- XMOBAR SETTINGS                                                           {{{
--------------------------------------------------------------------------------

myXmobar = "xmobar $HOME/.xmonad/xmobarrc"

myXmobarPP = xmobarPP { ppOrder           = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                      , ppCurrent         = xmobarColor "#c3e88d" "" . wrap "[" "]"
                      , ppVisible         = xmobarColor "#c3e88d" ""
                      , ppHidden          = xmobarColor "#82AAFF" "" . wrap "*" ""
                      , ppHiddenNoWindows = xmobarColor "#F07178" ""
                      , ppTitle           = xmobarColor "#d0d0d0" "" . shorten 80
                      , ppSep             = "<fc=#9AEDFE> : </fc>"
                      , ppUrgent          = xmobarColor "#C45500" "" . wrap "!" "!"
                      , ppExtras          = [myWindowCount]
                      }

-----------------------------------------------------------------------------}}}
-- STARTUPHOOK                                                               {{{
--------------------------------------------------------------------------------
myStartupHook = do
  spawn "$HOME/scripts/xmonad-autostart.sh"
  -- spawn "$HOME/.config/polybar/launch.sh"
  -- setWMName "LG3D"
  setWMName "Xmonad"


-----------------------------------------------------------------------------}}}
-- MANAGEHOOK                                                                {{{
--------------------------------------------------------------------------------
myManageHook = composeAll
    [ className =? "MPlayer"            --> doFloat
    , className =? "mplayer2"           --> doFloat
    , className =? "Pamac-manager"      --> doCenterFloat
    , className =? "pamac-manager"      --> doCenterFloat
    , className =? "VirtualBox Manager" --> doFloat
    , title     =? "org-capture"        --> doRectFloat (W.RationalRect (1 % 4) (1 % 4) (1 % 2) (1 % 3)) ]


-----------------------------------------------------------------------------}}}
-- LAYOUTHOOK                                                                {{{
--------------------------------------------------------------------------------
myLayoutHook =
    avoidStruts $
    spacingRaw True (Border 0 0 0 0) False (Border myWindowSpacing myWindowSpacing myWindowSpacing myWindowSpacing) True $
    -- onWorkspace "\xe401" Full $
    minimize (maximize (vertTiled ||| horzTiled ||| tabbed shrinkText myTabConfig ||| Full))

    where
        horzTiled = Mirror (Tall nmaster delta hRatio)

        -- default tiling algorithm partitions the screen into two panes
        vertTiled = Tall nmaster delta vRatio

        -- The default number of windows in the master pane
        nmaster   = 1

        -- Default proportion of screen occupied by master pane in vertical tiled mode
        vRatio    = 1/2

        -- Default proportion of screen occupied by master pane in horizontal tiled mode
        hRatio    = 4/5

        -- Percent of screen to increment by when resizing panes
        delta     = 3/100


-----------------------------------------------------------------------------}}}
-- LOGHOOK                                                                   {{{
--------------------------------------------------------------------------------
myLogHook h = dynamicLogWithPP $ myXmobarPP { ppOutput = hPutStrLn h }


-----------------------------------------------------------------------------}}}
-- KEYBINDINGS                                                               {{{
--------------------------------------------------------------------------------

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask .|. shiftMask,  xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modMask,                xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modMask,                xK_space ), spawn "rofi -show drun") -- %! Rofi launcher
    , ((modMask .|. shiftMask,  xK_0     ), spawn "rofi -show calc -modi calc -no-show-match -no-sort") -- %! Show calculator
    , ((modMask .|. shiftMask,  xK_n     ), spawn "~/scripts/networkmanager_dmenu") -- %! Show network manager
    , ((modMask .|. shiftMask,  xK_c     ), spawn "roficlip") -- %! Show clipboard history
    , ((modMask .|. shiftMask,  xK_w     ), spawn "rofi -show window") -- %! Show window list
    , ((modMask .|. shiftMask,  xK_s     ), spawn "flameshot gui -p ~/Pictures/Screenshots") -- %! Take screenshot
    , ((modMask .|. controlMask,xK_space ), spawn "rofi -modi \"Files:~/scripts/rofi-file-browser.sh\" -show Files") -- %! Show file browser
    , ((modMask,                xK_q     ), kill1) -- %! Close the focused window
    , ((modMask,                xK_p     ), spawnSelected def ["termite","emacs","firefox","termite -e ranger"]) -- %! Show grid launcher
    -- , ((mod4Mask,               xK_l     ), spawn "cinnamon-screensaver-command -l") -- %! Lock screen
    , ((mod4Mask,               xK_r     ), spawn "xfce4-terminal -e ranger") -- %! Launch Ranger
    , ((mod4Mask,               xK_e     ), spawn "emacs") -- %! Launch Emacs
    , ((mod4Mask,               xK_m     ), spawn "xfce4-terminal -e neomutt") -- %! Launch Neomutt
    , ((mod4Mask,               xK_n     ), spawn "xfce4-terminal -e newsboat") -- %! Launch Newsboat
    , ((mod4Mask,               xK_c     ), spawn "~/scripts/rofi-org-capture.sh") -- %! Emacs Org Capture
    -- , ((mod4Mask,               xK_f     ), spawn "nemo") -- %! Launch File Manager

    -- misc
    , ((mod4Mask .|. shiftMask, xK_f     ), sendMessage ToggleStruts) -- %! Toggle struts on/off
    , ((modMask,                xK_g     ), goToSelected def) -- %! Show open windows in grid
    , ((mod4Mask,               xK_minus ), windowMenu)

    -- quit, or restart
    , ((modMask .|. shiftMask,  xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask .|. shiftMask,  xK_r     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
    , ((modMask,                xK_0     ), spawn "~/scripts/rofi-session-manager-xfce.sh") -- %! Logout/Restart/Shutdown

    -- layout stuff
    , ((mod4Mask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((mod4Mask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    -- workspace switching
    , ((modMask .|. shiftMask .|. controlMask, xK_l),  nextWS)
    , ((modMask .|. shiftMask .|. controlMask, xK_h),  prevWS)

    -- maximize/minimize
    , ((mod4Mask,               xK_z     ), withFocused (sendMessage . maximizeRestore))
    -- , ((modMask .|. shiftMask,  xK_minus ), withFocused minimizeWindow)
    -- , ((modMask,                xK_minus ), sendMessage RestoreNextMinimizedWin)

    -- focus and master window handling
    , ((modMask,                xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask .|. shiftMask,  xK_Tab   ), windows W.focusUp) -- %! Move focus to the previous window
    , ((modMask,                xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window
    , ((mod4Mask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask,  xK_m     ), promote) -- %! Move the focused window to the master pane

    , ((modMask,                xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,                xK_k     ), windows W.focusUp) -- %! Move focus to the previous window
    , ((modMask,                xK_h     ), windows W.focusMaster) -- %! Move focus to the master window
    , ((modMask,                xK_l     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask .|. shiftMask,  xK_h     ), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask,  xK_l     ), windows W.swapDown) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask,  xK_j     ), windows W.swapDown) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask,  xK_k     ), windows W.swapUp) -- %! Swap the focused window with the previous window

    -- switch between layers
    , ((mod4Mask,               xK_Tab   ), switchLayer)

    -- directional navigation of windows
    -- , ((modMask,                xK_l     ), windowGo R False)
    -- , ((modMask,                xK_h     ), windowGo L False)
    -- , ((modMask,                xK_k     ), windowGo U False)
    -- , ((modMask,                xK_j     ), windowGo D False)

    -- Swap adjacent windows
    -- , ((modMask .|. shiftMask,  xK_l    ), windowSwap R False)
    -- , ((modMask .|. shiftMask,  xK_h    ), windowSwap L False)
    -- , ((modMask .|. shiftMask,  xK_k    ), windowSwap U False)
    -- , ((modMask .|. shiftMask,  xK_j    ), windowSwap D False)

    -- directional navigation of screens
    , ((mod4Mask,               xK_l     ), screenGo R False)
    , ((mod4Mask,               xK_h     ), screenGo L False)
    , ((mod4Mask,               xK_k     ), screenGo U False)
    , ((mod4Mask,               xK_j     ), screenGo D False)

    -- Swap adjacent screens
    -- , ((mod4Mask .|. shiftMask, xK_l    ), screenSwap R False)
    -- , ((mod4Mask .|. shiftMask, xK_h    ), screenSwap L False)
    -- , ((mod4Mask .|. shiftMask, xK_k    ), screenSwap U False)
    -- , ((mod4Mask .|. shiftMask, xK_j    ), screenSwap D False)

    -- resizing the master/slave ratio
    , ((mod4Mask .|. shiftMask, xK_k    ), sendMessage Shrink) -- %! Shrink the master area
    , ((mod4Mask .|. shiftMask, xK_j    ), sendMessage Expand) -- %! Expand the master area
    , ((mod4Mask .|. shiftMask, xK_minus), sendMessage Shrink) -- %! Shrink the master area
    , ((mod4Mask .|. shiftMask, xK_plus ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((mod4Mask,               xK_f     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask,                xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modMask,                xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- brightness controls
    , ((0,                      xF86XK_MonBrightnessUp  ), spawn "dbus-send --dest=org.cinnamon.SettingsDaemon.Power --type=method_call /org/cinnamon/SettingsDaemon/Power org.cinnamon.SettingsDaemon.Power.Screen.StepUp") -- %! Brightness up
    , ((0,                      xF86XK_MonBrightnessDown), spawn "dbus-send --dest=org.cinnamon.SettingsDaemon.Power --type=method_call /org/cinnamon/SettingsDaemon/Power org.cinnamon.SettingsDaemon.Power.Screen.StepDown") -- %! Brightness down

    -- volume controls
    , ((0,                      xF86XK_AudioRaiseVolume  ), spawn "~/scripts/volume.sh up") -- %! Volume up
    , ((0,                      xF86XK_AudioLowerVolume), spawn "~/scripts/volume.sh down") -- %! Volume down
    , ((0,                      xF86XK_AudioMute), spawn "~/scripts/volume.sh mute") -- %! Mute audio

    -- Search commands
    , ((mod4Mask,               xK_s     ), SM.submap $ searchEngineMap $ S.promptSearch P.def)
    , ((mod4Mask .|. shiftMask, xK_s     ), SM.submap $ searchEngineMap $ S.selectSearch)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask), (copy, shiftMask .|. controlMask)]]
    ++
    -- mod4-{1,2,3} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod4-shift-{1,2,3} %! Move client to screen 1, 2, or 3
    [((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_1, xK_2, xK_3] [0,2,1]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


-----------------------------------------------------------------------------}}}
-- MISC                                                                      {{{
--------------------------------------------------------------------------------
searchEngineMap method = M.fromList $
      [ ((0, xK_g), method S.google)
      , ((0, xK_h), method S.hoogle)
      , ((0, xK_w), method S.wikipedia)
      ]


-----------------------------------------------------------------------------}}}
-- MAIN                                                                      {{{
--------------------------------------------------------------------------------
main :: IO ()
main = do
    wsbar <- spawnPipe myXmobar

    xmonad
        $ ewmh
        $ withNavigation2DConfig def
        $ docks myConfig { logHook = myLogHook wsbar }
